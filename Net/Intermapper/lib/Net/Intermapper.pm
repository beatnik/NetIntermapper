package Net::Intermapper;
use strict;
use Moose;

# REST IO stuff here
use IO::Socket::SSL qw( SSL_VERIFY_NONE );
use LWP::UserAgent;

# Generics
use File::Path;
use URI::Escape;
use Text::CSV_XS;
use Data::Dumper;
use XML::Simple;

# Net::Intermapper::*
use Net::Intermapper::User;
use Net::Intermapper::Device;
use Net::Intermapper::Interface;
use Net::Intermapper::Map;
use Net::Intermapper::Vertice;

BEGIN {
    use Exporter ();
    use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS $ERROR);
    $VERSION     = '0.01';
    @ISA         = qw(Exporter);
    @EXPORT      = qw();
    @EXPORT_OK   = qw();
    %EXPORT_TAGS = ();
	
	$ERROR = ""; # TODO: Document error properly!
}

# Moose!

has 'ssl_options' => (
	is => 'rw',
	isa => 'HashRef',
	default => sub { { 'SSL_verify_mode' => SSL_VERIFY_NONE, 'verify_hostname' => '0' } }
	);

has 'ssl' => (
	is => 'rw',
	isa => 'Str',
	default => '1',
	);

has 'hostname' => (
	is => 'rw',
	isa => 'Str',
	required => '1',
	); 

has 'port' => (
	is => 'rw',
	isa => 'Int',
	default => sub { 8181 },
	); 

has 'modifyport' => (
	is => 'rw',
	isa => 'Int',
	default => sub { 443 },
	); 
	
has 'username' => (
	is => 'rw',
	isa => 'Str',
	default => sub { "admin" },
);

has 'password' => (
	is => 'rw',
	isa => 'Str',
	default => sub { "nmsadmin" },
);
	
has 'format' => (
	is => 'rw',
	isa => 'Str',
	default => sub { "csv" },
); 

sub users # No Moose here :(
{	my $self = shift;
    $ERROR = "";
	if (@_)
	{ my %args = @_; 
	  $self->{"Users"} = $args{"users"}; 
	} else
	{ $self->{"Users"} = $self->query("users"); 
	}
	return $self->{"Users"};
}	

sub devices # No Moose here :(
{	my $self = shift;
    $ERROR = "";
	if (@_)
	{ my %args = @_; 
	  $self->{"Devices"} = $args{"devices"}; 
	} else
	{ $self->{"Devices"} = $self->query("devices"); 
	}
	return $self->{"Devices"};
}	

sub interfaces # No Moose here :(
{	my $self = shift;
    $ERROR = "";
	if (@_)
	{ my %args = @_; 
	  $self->{"Interfaces"} = $args{"interfaces"}; 
	} else
	{ $self->{"Interfaces"} = $self->query("interfaces"); 
	}
	return $self->{"Interfaces"};
}	

sub maps # No Moose here :(
{	my $self = shift;
    $ERROR = "";
	if (@_)
	{ my %args = @_; 
	  $self->{"Maps"} = $args{"maps"}; 
	} else
	{ $self->{"Maps"} = $self->query("maps"); 
	}
	return $self->{"Maps"};
}	

sub vertices # No Moose here :(
{	my $self = shift;
    $ERROR = "";
	if (@_)
	{ my %args = @_; 
	  $self->{"Vertices"} = $args{"vertices"}; 
	} else
	{ $self->{"Vertices"} = $self->query("vertices"); 
	}
	return $self->{"Vertices"};
}	

sub query 
{ my ($self, $type) = @_;
  my $hostname = $self->hostname;
  my $username = $self->username;
  my $password = $self->password;
  my $port = $self->port;
  my $format = $self->format;
  if ($self->ssl)
  { $hostname = "https://$username:$password\@$hostname:$port"; } else
  { $hostname = "http://$username:$password\@$hostname:$port"; }
  $hostname .= "/~export/$type.$format"; 
  my $request = HTTP::Request->new("GET" => $hostname);
  my $useragent = LWP::UserAgent->new (ssl_opts => $self->ssl_options);

  my $result = $useragent->request($request);
  if ($result->code eq "400") { $ERROR = "Bad Request - HTTP Status: 400"; }
  if ($result->code eq "410") { $ERROR = "Unknown $type queried by name or ID - HTTP Status: 410"; }  
  if ($self->format eq "csv")
  { $self->parse_csv($type, $result->decoded_content); 
  }
  if ($self->format eq "tab")
  { $self->parse_tab($type, $result->decoded_content); 
  }

  if ($self->format eq "xml")
  { #$self->parse_xml($type, $result->content); # XML seems to be broken?!?
    warn Dumper $result->content;
  }
  
   return $self->{"Users"} if $type eq "users";
   return $self->{"Devices"} if $type eq "devices";
   return $self->{"Interfaces"} if $type eq "interfaces";
   return $self->{"Maps"} if $type eq "maps";
   return $self->{"Vertices"} if $type eq "vertices";
}

# It seems that Maps and Interfaces cannot be created?
sub create
{ my $self = shift;
  my $entry = shift;
  my $username = $self->username;
  my $password = $self->password;
  my $format = $self->format; # csv or xml (unsupported at this point)
  
  my $hostname = $self->hostname;
  my $port = $self->modifyport;
  if ($port ne "") { $port = ":$port"; }
  if ($self->ssl)
  { $hostname = "https://$username:$password\@$hostname$port/~import/file"; } else
  { $hostname = "http://$username:$password\@$hostname$port/~import/file"; }

  my $data = $entry->header($format);
  if ($format eq "csv")
  { $data .= $entry->toCSV; }
  if ($format eq "tab")
  { $data .= $entry->toTAB; }
  $data =~ s/^\s*//g;

  my $request = HTTP::Request->new(POST => "$hostname");
  my $useragent = LWP::UserAgent->new("ssl_opts" => $self->ssl_options);

  $request->content_type('application/x-www-form-urlencoded');
  $request->content($data);
  $request->header('Accept' => 'text/html');
  my $result = $useragent->request($request);
  return $result;
}

# This SHOULD be sufficient?
sub update
{ my $self = shift;
  my $entry = shift;
  $entry->mode("update");
  return $self->create($entry);
}

sub parse_xml # Broken!
{ my $self = shift;
  my $type = shift;
  my $xml_ref = shift;
  my $xmlsimple = XML::Simple->new();
  my $xmlout = $xmlsimple->XMLin($xml_ref);
  if ($type eq "users")
  { my $users_ref = $xmlout->{"users"};
    my %users = ();
    for my $key (@ {$users_ref})
    { my $user = Net::Intermapper::User->new(  @{ $key } );
      $users{$key} = $user;
    }
    $self->{"Users"} = \%users;
	return $self->{"Users"};
  }
  
  if ($type eq "devices")
  { my $devices_ref = $xmlout->{"devices"};
    my %devices = ();
    for my $key (@ {$devices_ref})
    { my $device = Net::Intermapper::Device->new(  @{ $key } );
      $devices{$key} = $device;
    }
    $self->{"Devices"} = \%devices;
	return $self->{"Devices"};
  }
  
  if ($type eq "interfaces")
  { my $interfaces_ref = $xmlout->{"interfaces"};
    my %interfaces = ();
    for my $key (@ {$interfaces_ref})
    { my $interface = Net::Intermapper::Interface->new(  @{ $key } );
      $interfaces{$key} = $interface;
    }
    $self->{"Interfaces"} = \%interfaces;
	return $self->{"Interfaces"};
  }
  
  if ($type eq "maps")
  { my $maps_ref = $xmlout->{"maps"};
    my %maps = ();
    for my $key (@ {$maps_ref})
    { my $map = Net::Intermapper::Map->new(  @{ $key } );
      $maps{$key} = $map;
    }
    $self->{"Maps"} = \%maps;
	return $self->{"Maps"};
  }

  if ($type eq "vertices")
  { my $vertices_ref = $xmlout->{"vertices"};
    my %vertices = ();
    for my $key (@ {$vertices_ref})
    { my $vertice = Net::Intermapper::Vertice->new(  @{ $key } );
      $vertices{$key} = $vertice;
    }
    $self->{"Vertices"} = \%vertices;
	return $self->{"Vertices"};
  }
 
}

sub parse_csv
{ my $self = shift;
  my $type = shift;
  my $csv_ref = shift;
  my @header = ();
  my %data = ();
  if ($type eq "users")
  { @header = @Net::Intermapper::User::HEADERS; }
  if ($type eq "devices")
  { @header = @Net::Intermapper::Device::HEADERS; }
  if ($type eq "interfaces")
  { @header = @Net::Intermapper::Interface::HEADERS; }
  if ($type eq "maps")
  { @header = @Net::Intermapper::Map::HEADERS; }
  if ($type eq "vertices")
  { @header = @Net::Intermapper::Vertice::HEADERS; }
  
  my @lines = split(/\r\n/,$csv_ref);
  my $csv = Text::CSV_XS->new ({ "auto_diag" => "1", "binary" => "1" });
  for my $line (@lines)
  { my $i = 0;
    my %fields = ();
    if ($csv->parse ($line)) 
    { my @fields = $csv->fields;
      for my $field (@fields)
      { $fields{$header[$i]} = $field;
	    $i++;
	  }
	  if ($type eq "users")
	  { my $user = Net::Intermapper::User->new( %fields );
          $data{$user->Name} = $user;
      }
  	  if ($type eq "devices")
	  { my $device = Net::Intermapper::Device->new( %fields );
          $data{$device->Name} = $device;
      }
  	  if ($type eq "interfaces")
	  { my $interface = Net::Intermapper::Interface->new( %fields );
          $data{$interface->InterfaceID} = $interface;
      }
   	  if ($type eq "maps")
	  { my $map = Net::Intermapper::Map->new( %fields );
          $data{$map->MapName} = $map;
      }
   	  if ($type eq "vertices")
	  { my $vertice = Net::Intermapper::Vertice->new( %fields );
          $data{$vertice->Name} = $vertice;
      }

	}
  }
  if ($type eq "users")
  { $self->{"Users"} = \%data;
    return $self->{"Users"};
  }
  if ($type eq "devices")
  { $self->{"Devices"} = \%data;
    return $self->{"Devices"};
  }
  if ($type eq "interfaces")
  { $self->{"Interfaces"} = \%data;
    return $self->{"Interfaces"};
  }
  if ($type eq "maps")
  { $self->{"Maps"} = \%data;
    return $self->{"Maps"};
  }
  if ($type eq "vertices")
  { $self->{"Vertices"} = \%data;
    return $self->{"Vertices"};
  }

}

sub parse_tab
{ my $self = shift;
  my $type = shift;
  my $tab_ref = shift;
  my @header = ();
  my %data = ();
  if ($type eq "users")
  { @header = @Net::Intermapper::User::HEADERS; }
  if ($type eq "devices")
  { @header = @Net::Intermapper::Device::HEADERS; }
  if ($type eq "interfaces")
  { @header = @Net::Intermapper::Interface::HEADERS; }
  if ($type eq "maps")
  { @header = @Net::Intermapper::Map::HEADERS; }
  if ($type eq "vertices")
  { @header = @Net::Intermapper::Vertice::HEADERS; }
  my $linecount = 0;
  my @lines = split(/[\r\n]{1,2}/,$tab_ref);
  for my $line (@lines)
  { my $i = 0;
    my %fields = ();
    my @fields = split(/\t/,$line);
    if (!$linecount) { $linecount++; next; } # Skip header line - KNOWN VALUES
    for my $field (@fields)
    { $fields{$header[$i]} = $field;
	  $i++;
	}
	if ($type eq "users")
	{ my $user = Net::Intermapper::User->new( %fields );
      $data{$user->Name} = $user;
    }
  	if ($type eq "devices")
	{ my $device = Net::Intermapper::Device->new( %fields );
      $data{$device->Name} = $device;
    }
  	if ($type eq "interfaces")
	{ my $interface = Net::Intermapper::Interface->new( %fields );
      $data{$interface->InterfaceID} = $interface;
    }
   	if ($type eq "maps")
	{ my $map = Net::Intermapper::Map->new( %fields );
      $data{$map->MapName} = $map;
    }
   	if ($type eq "vertices")
	{ my $vertice = Net::Intermapper::Vertice->new( %fields );
      $data{$vertice->Name} = $vertice;
    }
  }
  if ($type eq "users")
  { $self->{"Users"} = \%data;
    return $self->{"Users"};
  }
  if ($type eq "devices")
  { $self->{"Devices"} = \%data;
    return $self->{"Devices"};
  }
  if ($type eq "interfaces")
  { $self->{"Interfaces"} = \%data;
    return $self->{"Interfaces"};
  }
  if ($type eq "maps")
  { $self->{"Maps"} = \%data;
    return $self->{"Maps"};
  }
  if ($type eq "vertices")
  { $self->{"Vertices"} = \%data;
    return $self->{"Vertices"};
  }

}

=cut

=head1 NAME

Net::Intermapper - Interface with the HelpSystems Intermapper HTTP API

=head1 SYNOPSIS

  use Net::Intermapper;
  my $intermapper = Net::Intermapper->new(hostname=>"10.132.96.100", username=>"admin", password=>"nmsadmin");
  # Options:
  # hostname - IP or hostname of Intermapper 5.x server
  # username - Username of Administrator user
  # password - Password of user
  # ssl - SSL enabled (1 - default) or disabled (0)
  # port - TCP port for querying information. Defaults to 8181
  # modifyport - TCP port for modifying information. Default to 443

  print Dumper $intermapper->users;
  # Retrieve all users from Intermapper
  # Returns hash with user name / Net::Intermapper::User pairs
  
  print Dumper $intermapper->devices;
  # Retrieve all devices from Intermapper
  # Returns hash with device name / Net::Intermapper::Device pairs
  
  print Dumper $intermapper->maps;
  # Retrieve all maps from Intermapper
  # Returns hash with map name / Net::Intermapper::Map pairs
  
  print Dumper $intermapper->interfaces;
  # Retrieve all interfaces from Intermapper
  # Returns hash with interface ID / Net::Intermapper::Interface pairs
  
  print Dumper $intermapper->vertices;  
  # Retrieve all vertices from Intermapper
  # Returns hash with name / Net::Intermapper::Vertice pairs

  my $user = $intermapper->users->{"admin"};
  print $user->header; 
  # Generate 'directive' needed for manipulation. Mostly used internally.
  # $user->mode("create"); # This changes the header fields
  # $user->mode("update"); # This also changes the header fields
  # Both are NOT needed when adding or updating a record
  print $user->toTAB;
  print $user->toXML;
  print $user->toCSV;
  # Produce human-readable output of each record. 
  
  my $user = Net::Intermapper::User->new(Name=>"testuser", Password=>"Test12345");
  print Dumper $intermapper->create($user);
  # Create new user
  
  my $device = Net::Intermapper::Device->new(.......);
  print Dumper $intermapper->create($device);
  # Create new device

  $user->Password("Foobar123");
  $intermapper->update($user);
  # Update existing user
   
=head1 DESCRIPTION

Net::Intermapper is a perl wrapper around the HelpSystems Intermapper API provided through HTTP/HTTPS for access to user accounts, device information, maps, interfaces and graphical elements.

All calls are handled through an instance of the L<Net::Intermapper> class.

  use Net::Intermapper;
  my $intermapper = Net::Intermapper->new(hostname => '10.0.0.1', username => 'admin', password => 'nmsadmin');

=over 3

=item new

Class constructor. Returns object of Net::Intermapper on succes. Required fields are:

=over 5

=item hostname

=item username

=password

=back

Optional fields are

=over 5

=item ssl

=item ssl_options

=back

=item hostname

IP or hostname of Intermapper server. This is a required value in the constructor but can be redefined afterwards. 

=item username

Username of Administrator user. This is a required value in the constructor but can be redefined afterwards.
As the API is used a different mechanism to query information than it uses to update, this needs to be changed when switching. Typically, the built-in C<admin> user is used for modifying a record. 
This value is not automatically changed when running C<create> or C<update>. 

=item password

Password of user. This is a required value in the constructor but can be redefined afterwards.
As the API is used a different mechanism to query information than it uses to update, this needs to be changed when switching. Typically, the built-in C<admin> user is used for modifying a record. 
This value is not automatically changed when running C<create> or C<update>.

=item ssl

SSL enabled (1 - default) or disabled (0). 

=item ssl_options

Value is passed directly to LWP::UserAGent as ssl_opt. Default value (hash-ref) is

  { 'SSL_verify_mode' => SSL_VERIFY_NONE, 'verify_hostname' => '0' }

=back

=item port

TCP port used for queries. This is an optional value in the constructor but can be redefined afterwards. By default, this is set to 8181.
As the API is used a different mechanism to query information than it uses to update, the C<port> value is used for queries only and is automatically switched. Set this ONLY if you have customized Intermapper to listen to a different port.

=back

=item modifyport

TCP port used for modifying values. This is an optional value in the constructor but can be redefined afterwards. By default, this is set to 443.
As the API is used a different mechanism to modify (create and update) information than it uses to query, the C<modifyport> value is used for modifying only and is automatically switched. Set this ONLY if you have customized Intermapper to listen to a different port.

=back

From the class instance, call the different methods for retrieving values.

=over 3

=item users

Returns all users

  my %users = $intermapper->users(); 
  print $user->name;
	
The returned hash contains instances of L<Net::Intermapper::User>, using name (typically the username) as the hash key. 
	
=item devices

Returns hash or single instance of L<Net::Intermapper::Device>, using name (typically the username) as the hash key. 

  my %devices = $intermapper->devices(); 
  print $device->name;
	
=item create

This method created a new entry in Intermapper, depending on the argument passed. Record type is detected automatically.

  $intermapper->username("admin");
  $intermapper->password("nmsadmin");
  my $user = Net::Intermapper::User->new(Name=>"testuser", Password=>"Test12345");
  $intermapper->create($user); 
  # Error checking needs to be added
  # print $Net::Intermapper::ERROR unless $id; 
  # $Net::Intermapper::ERROR contains details about failure

  # Add more examples
  
=item update

This method updates an existing entry in Intermapper, depending on the argument passed. Record type is detected automatically. 

  my $user = $intermapper->users->{"testuser"};
  $user->Password("TopSecret"); # Change password. Password policies will be enforced!
  $intermapper->update($user);
  # Error checking needs to be added
  # Update user based on Net::Intermapper::User instance
  print $Net::Intermapper::ERROR unless $id;
  # $Net::Intermapper::ERROR contains details about failure

=item $ERROR

NEEDS TO BE ADDED

This variable will contain detailed error information.	
	
=back

=head1 REQUIREMENTS

For this library to work, you need an instance with Intermapper (obviously) or a simulator like L<Net::Intermapper::Mock>. 

=over 3

=item L<Moose>

=item L<IO::Socket::SSL>

=item L<LWP::UserAgent>

=item L<XML::Simple>

=item L<MIME::Base64>

=item L<URI::Escape>

=back
	
=head1 BUGS

None so far

=head1 SUPPORT

None so far :)

=head1 AUTHOR

    Hendrik Van Belleghem
    CPAN ID: BEATNIK
    hendrik.vanbelleghem@gmail.com

=head1 COPYRIGHT

This program is free software licensed under the...

	The General Public License (GPL)
	Version 2, June 1991

The full text of the license can be found in the
LICENSE file included with this module.


=head1 SEE ALSO

perl(1).

=cut

#################### main pod documentation end ###################

__PACKAGE__->meta->make_immutable();

1;
# The preceding line will help the module return a true value

