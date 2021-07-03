require 'json'

# Read JSON data
file = File.read('lib/config.json')
ORG_STRUCTURE = JSON.parse(file)

# Set required constants. All monetary values stored in pence
VAT = 1.2

MIN_RENT_WEEK = 2500
MIN_RENT_MONTH = 11000

MAX_RENT_WEEK = 200000
MAX_RENT_MONTH = 866000

# Create data models
class OrganisationUnit
  def initialize(attributes = {})
    @name = attributes[:name]
    @config = attributes[:OrganisationUnitConfig]
  end
end

class OrganisationUnitConfig
  def initialize(attributes = {})
    @has_fixed_membership_fee = attributes[:has_fixed_membership_fee]
    @fixed_membership_fee_amount = attributes[:fixed_membership_fee_amount]
  end
end

# Method to determine if a branch has a fixed fee
def org_unit_has_fixed_fee(organisation_unit)
  name = ORG_STRUCTURE.find { |h1| h1['name'] == "branch_#{organisation_unit}" }
  if name['config'].nil?
    parent = name['parent']
    ORG_STRUCTURE.find { |h1| h1['name'] == "#{parent}" }['config']['fixed_membership_fee_amount']
  else
    name['config']['fixed_membership_fee_amount']
  end
end

# Validation method
def validation_rent_amount(rent_amount, rent_period)
  if rent_amount < MIN_RENT_WEEK && rent_period == 'week'
    raise TypeError.new('Weekly rent_amount must be above minimum value of 2500')
  elsif rent_amount < MIN_RENT_MONTH && rent_period == 'month'
    raise TypeError.new('Monthly rent_amount must be above minimum value of 11000')
  elsif rent_amount > MAX_RENT_WEEK && rent_period == 'week'
    raise TypeError.new('Weekly rent_amount must be below maximum value of 200000')
  elsif rent_amount > MAX_RENT_MONTH && rent_period == 'month'
    raise TypeError.new('Monthly rent_amount must be below maximum value of 866000')
  end
end

# Main calculation method
def calculate_membership_fee(rent_amount, rent_period, organisation_unit)
  # initiate validation to check inputs are correct
  if validation_rent_amount(rent_amount, rent_period) == nil
    if org_unit_has_fixed_fee(organisation_unit) == 0
      if rent_period == 'week' && rent_amount > 12000
        (rent_amount * VAT).round
      elsif rent_period == 'month' && ((rent_amount * 12) / 52) > 12000
        ((rent_amount * 12 / 52) * VAT).round
      else
        (12000 * VAT).round
      end
    else
      org_unit_has_fixed_fee(organisation_unit)
    end
  end
end
