FactoryGirl.define do
  factory :product do
    name "MyString"
    wieght "9.99"
    hangar
  end

  factory :invalid_product, class: 'Product' do
    name nil
    wieght nil
    hangar nil
  end
end
