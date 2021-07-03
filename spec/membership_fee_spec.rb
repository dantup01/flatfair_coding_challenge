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

