require 'membership_fee'

# Test reading JSON file works and returns fixed fee data

context 'branch_a has no config so returns area_a and' do
  it { expect(org_unit_has_fixed_fee('a')).to eq(45000) }
end

context 'branch_b fixed fee' do
  it { expect(org_unit_has_fixed_fee('b')).to eq(0) }
end

context 'branch_m has no config so returns area_d and' do
  it { expect(org_unit_has_fixed_fee('m')).to eq(0) }
end

# Test validations of min/max weekly/monthly rent amounts

context 'Validation of min weekly rent amount' do
  it { expect { validation_rent_amount(2400, 'week') }.to raise_error('Weekly rent_amount must be above minimum value of 2500') }
end

context 'Validation of min monthly rent amount' do
  it { expect { validation_rent_amount(10000, 'month') }.to raise_error('Monthly rent_amount must be above minimum value of 11000') }
end

context 'Validation of max weekly rent amount' do
  it { expect { validation_rent_amount(200001, 'week') }.to raise_error('Weekly rent_amount must be below maximum value of 200000') }
end

context 'Validation of max monthly rent amount' do
  it { expect { validation_rent_amount(866001, 'month') }.to raise_error('Monthly rent_amount must be below maximum value of 866000') }
end

# Test membership fee calculator

context 'A rent amount of 18000 with a weekly rent period paid to branch_a will be a fixed fee therefore' do
  it { expect(calculate_membership_fee(18000, 'week', 'a')).to eq(45000) }
end

context 'A rent amount of 13000 with a weekly rent period paid to branch_b' do
  it { expect(calculate_membership_fee(13000, 'week', 'b')).to eq(15600) }
end

context 'A rent amount of 30000 with a monthly rent period paid to branch_o is below minimum fee therefore' do
  it { expect(calculate_membership_fee(30000, 'month', 'o')).to eq(14400) }
end

context 'A rent amount of 300000 with a monthly rent period paid to branch_o is below minimum fee therefore' do
  it { expect(calculate_membership_fee(300000, 'month', 'o')).to eq(83076) }
end
