package Net::Intermapper::Map;
use strict;
use Moose;

BEGIN {
    use Exporter ();
    use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS @HEADERS);
    $VERSION     = '0.02';
    @ISA         = qw(Exporter);
    @EXPORT      = qw();
    @EXPORT_OK   = qw();
    %EXPORT_TAGS = ();
	
	@HEADERS = qw(MapId MapName MapPath Status DeviceCount NetworkCount InterfaceCount DownCount CriticalCount AlarmCount WarningCount OkayCount DataRetentionPolicy IMID Enabled Layer2);
};

# MOOSE!

has 'MapId' => (
    is  => 'rw',
    isa => 'Str',
	default => sub { ""; },	  
  );

has 'MapName' => (
    is  => 'rw',
    isa => 'Str',
	default => sub { ""; },
  );

has 'MapPath' => (
    is  => 'rw',
    isa => 'Str',
	default => sub { "/"; },
  );

has 'Status' => (
    is  => 'rw',
    isa => 'Str',
	default => sub { ""; },	
  );

has 'DeviceCount' => (
    is  => 'ro',
	isa => 'Str',
  );

has 'NetworkCount' => (
    is  => 'ro',
    isa => 'Str',
  );

has 'InterfaceCount' => (
    is  => 'ro',
    isa => 'Str',
  );

has 'DownCount' => (
    is  => 'ro',
    isa => 'Str',
  );

has 'CriticalCount' => (
    is  => 'ro',
    isa => 'Str',
  );

has 'AlarmCount' => (
    is  => 'ro',
    isa => 'Str',
  );

has 'WarningCount' => (
    is  => 'ro',
    isa => 'Str',
  );

has 'OkayCount' => (
    is  => 'ro',
    isa => 'Str',
  );

has 'DataRetentionPolicy' => (
    is  => 'rw',
    isa => 'Str',
  );

has 'IMID' => (
    is  => 'rw',
    isa => 'Str',
  );

has 'Enabled' => (
    is  => 'rw',
    isa => 'Str',
	default => sub { ""; },
  );

has 'Layer2' => (
    is  => 'rw',
    isa => 'Str',
	);

# This methode is used for generating only wanted fields..
has 'mode' => ( # create, update, delete
	is => 'rw',
	isa => 'Str',
	default => sub { "create"; },
	);
	
# No Moose	
	
sub toXML
{ my $self = shift;
  my $id = $self->Id;
  my $result = "";
  my $mapid = $self->MapId;
  my $mapname = $self->MapName || "";
  my $mappath = $self->MapPath || "";
  my $status = $self->Status || "";
  my $devicecount = $self->DeviceCount || "";
  my $networkcount = $self->NetworkCount || "";
  my $interfacecount = $self->InterfaceCount || "";
  my $downcount = $self->DownCount || "";
  my $criticalcount = $self->CriticalCount || "";
  my $alarmcount = $self->AlarmCount || "";
  my $warningcount = $self->WarningCount || "";
  my $okaycount = $self->OkayCount || "";
  my $dataretentionpolicy = $self->DataRetentionPolicy || "";
  my $imid = $self->IMID || "";
  my $enabled = $self->Enabled || "";
  my $layer2 = $self->Layer2 || "";
  if ($id) { $result = "   <id>$id</id>\n"; }
return $result;
}

sub toCSV
{ my $self = shift;
  my $id = $self->Id;
  my $result = "";
  my @attributes = $self->meta->get_all_attributes;
  my %attributes = ();
  for my $attribute (@attributes)
  { $attributes{$attribute->name} = $attribute->get_value($self) || "";
  }
  for my $key (@HEADERS)
  { if ($self->mode eq "create")
    { next if $key eq "MapId";
	  next if $key eq "Status";
	  next if $key eq "DeviceCount";
	  next if $key eq "NetworkCount";
	  next if $key eq "InterfaceCount";
	  next if $key eq "DownCount";
	  next if $key eq "CriticalCount";
	  next if $key eq "AlarmCount";
	  next if $key eq "WarningCount";
	  next if $key eq "OkayCount";
	  next if $key eq "DataRetentionPolicy";
	  next if $key eq "Enabled";
	  next if $key eq "Layer2";
	  next if $key eq "IMID";
      $result .= $attributes{$key}.","; }
  }
  chop $result; # Remove the comma of the last field
  $result =~ s/\s$//g;
  $result .= "\r\n";
  return $result;
}

sub toTAB
{ my $self = shift;
  my $mapid = $self->MapId;
  my $result = "";
  my @attributes = $self->meta->get_all_attributes;
  my %attributes = ();
  for my $attribute (@attributes)
  { $attributes{$attribute->name} = $attribute->get_value($self) || "";
  }
  for my $key (@HEADERS)
  { if ($self->mode eq "create")
    { next if $key eq "MapId";
	  next if $key eq "Status";
	  next if $key eq "DeviceCount";
	  next if $key eq "NetworkCount";
	  next if $key eq "InterfaceCount";
	  next if $key eq "DownCount";
	  next if $key eq "CriticalCount";
	  next if $key eq "AlarmCount";
	  next if $key eq "WarningCount";
	  next if $key eq "OkayCount";
	  next if $key eq "DataRetentionPolicy";
	  next if $key eq "Enabled";
	  next if $key eq "Layer2";
	  next if $key eq "IMID";
      $result .= $attributes{$key}."\t"; 
	}
  }
  chop $result; # Remove the comma of the last field
  $result =~ s/\s$//g;
  $result .= "\r\n";
  return $result;
}

sub header
{ my $self = shift;
  my $format = shift || "";
  my $header = "# format=$format table=maps fields="; 
  for my $key (@HEADERS)
  { next if $key eq "MapId";
	next if $key eq "Status";
	next if $key eq "DeviceCount";
	next if $key eq "NetworkCount";
	next if $key eq "InterfaceCount";
	next if $key eq "DownCount";
	next if $key eq "CriticalCount";
	next if $key eq "AlarmCount";
	next if $key eq "WarningCount";
	next if $key eq "OkayCount";
	next if $key eq "DataRetentionPolicy";
	next if $key eq "Enabled";
	next if $key eq "Layer2";
	next if $key eq "IMID";
    $header .= $key."\t,"; 
  }
  chop $header;
  $header .= "\r\n";
  return $header;
}
	
=head1 NAME

Net::Cisco::ACS::User - Access Cisco ACS functionality through REST API - User fields

=head1 SYNOPSIS

	use Net::Cisco::ACS;
	use Net::Cisco::ACS::User;
  
	my $acs = Net::Cisco::ACS->new(hostname => '10.0.0.1', username => 'acsadmin', password => 'testPassword');
	my $user = Net::Cisco::ACS::User->new("name"=>"soloh","description"=>"Han Solo","identityGroupName"=>"All Groups:MilleniumCrew","password"=>"Leia");

	my %users = $acs->users;
	# Retrieve all users from ACS
	# Returns hash with username / Net::Cisco::ACS::User pairs
	
	print $acs->users->{"acsadmin"}->toXML;
	# Dump in XML format (used by ACS for API calls)
	
	my $user = $acs->users("name","acsadmin");
	# Faster call to request specific user information by name

	my $user = $acs->users("id","150");
	# Faster call to request specific user information by ID (assigned by ACS, present in Net::Cisco::ACS::User)

	$user->id(0); # Required for new user!
	my $id = $acs->create($user);
	# Create new user based on Net::Cisco::ACS::User instance
	# Return value is ID generated by ACS
	print "Record ID is $id" if $id;
	print $Net::Cisco::ACS::ERROR unless $id;
	# $Net::Cisco::ACS::ERROR contains details about failure

	my $id = $acs->update($user);
	# Update existing user based on Net::Cisco::ACS::User instance
	# Return value is ID generated by ACS
	print "Record ID is $id" if $id;
	print $Net::Cisco::ACS::ERROR unless $id;
	# $Net::Cisco::ACS::ERROR contains details about failure

	$acs->delete($user);
	# Delete existing user based on Net::Cisco::ACS::User instance
	
=head1 DESCRIPTION

The Net::Cisco::ACS::User class holds all the user relevant information from Cisco ACS 5.x

=head1 USAGE

All calls are typically handled through an instance of the L<Net::Cisco::ACS> class. L<Net::Cisco::ACS::User> acts as a container for user related information.

=over 3

=item new

Class constructor. Returns object of Net::Cisco::ACS::User on succes. The following fields can be set / retrieved:

=over 5

=item description 
=item name 
=item identityGroupName
=item enablePassword
=item enabled
=item password
=item passwordNeverExpires
=item passwordType
=item dateExceeds
=item dateExceedsEnabled
=item id

Formatting rules may be in place & enforced by Cisco ACS.

=back

Read-only values:

=over 5

=item changePassword
=item created
=item attributeInfo
=item lastLogin
=item lastModified
=item lastPasswordChange
=item loginFailuresCounter

=back

=over 3

=item description 

The user account description, typically used for full name.

=item name 

The user account name. This is a required value in the constructor but can be redefined afterwards.

=item identityGroupName

The user group name. This is a required value in the constructor but can be redefined afterwards. See L<Net::Cisco::ACS::IdentityGroupName>.

=item enablePassword

The enable password (for Cisco-level access), not needed if you work with command sets in your access policies.

=item enabled

Boolean flag to indicate account status.

=item password

Password. When querying user account information, the password will be masked as *********. This is a required value in the constructor but can be redefined afterwards.

=item passwordNeverExpires

Boolean flag to indicate account expiration status.

=item passwordType

A read-only valie that indicates the password type, either for Internal User or Active Directory (needs confirmation).

=item dateExceeds

Date field to automatically deactivate the account once passed.

=item dateExceedsEnabled

Boolean flag to activate the automatic deactivation feature based on expiration dates.

=item id

Cisco ACS generates a unique ID for each User record. This field cannot be updated within ACS but is used for reference. Set to 0 when creating a new record or when duplicating an existing user.

=item toXML

Dump the record in ACS accept XML formatting (without header).

=item header

Generate the correct XML header. Takes output of C<toXML> as argument.

=back

=head1 BUGS

None yet

=head1 SUPPORT

None yet :)

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

