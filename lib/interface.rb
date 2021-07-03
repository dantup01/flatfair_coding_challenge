require_relative 'membership_fee'

p 'Welcome to the flatfair membership fee calculator'
p 'How often do you pay rent? Enter week or month:'
print '> '
rent_period = gets.chomp.downcase

if rent_period.eql?('week') || rent_period.eql?('month')
  p 'Enter rent amount in pence:'
  print '> '
  rent_amount = gets.chomp.to_i

  if validation_rent_amount(rent_amount, rent_period) == nil
    p
  else
    p validation_rent_amount(rent_amount, rent_period)
  end

  p 'Which branch do you pay rent to? Enter a branch letter between a-p:'
  print '> '
  organisation_unit = gets.chomp.downcase

  print "Your membership fee is: "
  p calculate_membership_fee(rent_amount, rent_period, organisation_unit)
else
  p "invalid"
end

