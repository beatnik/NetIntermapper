package Net::Intermapper::Vertice;
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
	
	@HEADERS = qw(MapName Id Name Color FontName FontSize FontStyle Label LabelPosition LabelTemplate LabelVisible MapId Origin Shape VantagePoint XCoordinate YCoordinate VertexId);
};

# MOOSE!

has 'MapName' => (
      is  => 'rw',
      isa => 'Str',
  );

has 'Id' => (
      is  => 'rw',
      isa => 'Str',
  );

has 'Name' => (
      is  => 'rw',
      isa => 'Str',
  );

has 'Color' => (
      is  => 'rw',
      isa => 'Str',
  );

has 'FontName' => (
      is  => 'rw',
      isa => 'Str',
  );

has 'FontSize' => (
      is  => 'rw',
      isa => 'Str',
  );

has 'FontStyle' => (
      is  => 'rw',
      isa => 'Str',
  );

has 'Label' => (
      is  => 'rw',
      isa => 'Str',
  );

has 'LabelPosition' => (
      is  => 'rw',
      isa => 'Str',
  );

has 'LabelTemplate' => (
      is  => 'rw',
      isa => 'Str',
  );

has 'LabelVisible' => (
      is  => 'rw',
      isa => 'Str',
  );

has 'MapId' => (
      is  => 'rw',
      isa => 'Str',
  );

has 'Origin' => (
      is  => 'rw',
      isa => 'Str',
  );

has 'Shape' => (
      is  => 'rw',
      isa => 'Str',
  );

has 'VantagePoint' => (
      is  => 'rw',
      isa => 'Str',
  );

has 'XCoordinate' => (
      is  => 'rw',
      isa => 'Str',
  );

has 'YCoordinate' => (
      is  => 'rw',
      isa => 'Str',
  );

has 'VertexId' => (
      is  => 'rw',
      isa => 'Str',
  );

# No Moose	
	
sub toXML
{ my $self = shift;
  my $id = $self->Id;
  my $result = "";
  
  if ($id) { $result = "   <id>$id</id>\n"; }
return $result;
}

sub header
{ my $self = shift;
  my $users = shift;
  return qq{<?xml version="1.0" encoding="UTF-8" standalone="yes"?><ns2:user xmlns:ns2="identity.rest.mgmt.acs.nm.cisco.com">$users</ns2:user>};
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
