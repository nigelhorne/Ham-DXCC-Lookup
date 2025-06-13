package Ham::DXCC::Lookup::DB::ctydat_full;

# ctydat_full.csv driver

use Database::Abstraction;

our @ISA = ('Database::Abstraction');

# Standard CSV file - ',' separator and the first column is not "entry"
sub new
{
	my $class = shift;
	my %args = (ref($_[0]) eq 'HASH') ? %{$_[0]} : @_;

	return $class->SUPER::new(no_entry => 1, sep_char => ',', %args);
}

1;
