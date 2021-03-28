guard "puma" do
  watch("Gemfile.lock")
  watch(/^docs\/|.+\.(rb|ru)$/)
end

guard "livereload" do
  watch(/.+\.(rb|ru)$/)
end

guard :standardrb, fix: true do
  UI.info "StandardRb is initialized"
  watch(/.+\.(rb|ru)$/)
end
