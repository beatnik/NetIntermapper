package Net::Intermapper::Device;
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
	
	@HEADERS = qw(MapName MapPath Address Id Name Probe Comment Community DisplayIfUnNumbered DNSName IgnoreIfAppleTalk IgnoreIfDiscards IgnoreIfErrors IgnoreOutages AllowPeriodicProbe IMProbe Latitude Longtitude
LastTimeDown LastTimeSysUp LastTimeUp MACAddress MapAs MapId MaxTries NetBiosName PctLoss ShortTermPctLoss Availability PollInterval Port Resolve RoundTripTime SNMPv3AuthPassword SNMPv3AuthProtocol
SNMPv3PrivPassword SNMPv3PrivProtocol SNMPv3UserName SNMPVersion Status StatusLevel StatusLevelReason SysDescr SysName SysContact SysLocation SysObjectID TimeOut IMID Type ProbeXML SNMPVersionInt
SysServices EntServialNum EntMfgName EntModelName DataRetentionPolicy CustomerNameReference EnterpriseID DeviceKind SysUpTime LastModified Parent Acknowledge AckMessage AckExpiration AckTimer VertexID Layer2);

};

# MOOSE!

# I'm lazy.. Yes, there were auto-generated!		   
has 'MapName' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },
  );

has 'MapPath' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "/" },	  
  );

has 'Address' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  
  );

has 'Id' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  
  );

has 'Name' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  
  );

has 'Probe' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "Ping/Echo" }, # SNMP Traffic
  );

has 'Comment' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'Community' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "public" },	  	  
  );

has 'DisplayIfUnNumbered' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "false" },
  );

has 'DNSName' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  
  );

has 'IgnoreIfAppleTalk' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  
  );

has 'IgnoreIfDiscards' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },
  );

has 'IgnoreIfErrors' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'IgnoreOutages' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'AllowPeriodicProbe' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'IMProbe' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'Latitude' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'Longtitude' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'LastTimeDown' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'LastTimeSysUp' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'LastTimeUp' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'MACAddress' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'MapAs' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'MapId,' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'MaxTries' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'NetBiosName' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'PctLoss' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'ShortTermPctLoss' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'Availability' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'PollInterval' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'Port' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'Resolve' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'RoundTripTime' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  
  );

has 'SNMPv3AuthPassword' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'SNMPv3AuthProtocol' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'SNMPv3PrivPassword' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  
  );

has 'SNMPv3PrivProtocol' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  
  );

has 'SNMPv3UserName' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  
  );

has 'SNMPVersion' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  
  );

has 'Status' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  
  );

has 'StatusLevel' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'StatusLevelReason' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'SysDescr' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'SysName' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'SysContact' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'SysLocation' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'SysObjectID' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'TimeOut' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'IMID' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'Type' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'ProbeXML' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'SNMPVersionInt' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'SysServices' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'EntServialNum' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'EntMfgName' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'EntModelName' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'DataRetentionPolicy' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'CustomerNameReference' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  
  );

has 'EnterpriseID' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'DeviceKind' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'SysUpTime' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'LastModified' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'Parent' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'Acknowledge' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'AckMessage' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'AckExpiration' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'AckTimer' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  
  );

has 'VertexID' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'Layer2' => (
      is  => 'rw',
      isa => 'Str',
	  default => sub { "" },	  	  
  );

has 'mode' => ( # create, update, delete
	is => 'rw',
	isa => 'Str',
	default => sub { "create"; },
	);
  
# No Moose	
	
sub toXML
{ my $self = shift;
  my $id = shift;
  my $result;
 # Need to build the XML formatting!!
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
    { next if $key eq "Id";
	  next if $key eq "mode";
      $result .= $attributes{$key}.","; 
	}
	if ($self->mode eq "update")
    { next if $key eq "mode";
	  $result .= $attributes{$key}."\t"; 
	}
  }
  chop $result; # Remove the comma of the last field
  $result =~ s/\s$//g;
  $result .= "\r\n";
  return $result;
}

sub toTAB
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
    { next if $key eq "Id";
	  next if $key eq "mode";
	  $result .= $attributes{$key}."\t"; 
	}
	if ($self->mode eq "update")
    { next if $key eq "mode";
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
  my $header = "# format=$format table=devices fields="; 
  for my $key (@HEADERS)
  { if ($self->mode eq "create")
    { next if $key eq "Id";
	  $header .= $key."\t,"; 
	}
	if ($self->mode eq "update")
    { $header .= $key."\t,"; 
	}
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

