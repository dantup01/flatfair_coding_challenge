require 'json'

# Read JSON data
file = File.read('lib/config.json')
ORG_STRUCTURE = JSON.parse(file)

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
