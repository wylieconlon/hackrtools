
if Rails.env.development?
  %w[item article snippet].each do |c|
    require_dependency File.join("app","models","#{c}.rb")
  end
end
