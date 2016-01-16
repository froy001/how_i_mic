class CreateAdminService
  def call
    user = User.find_or_create_by!(email: Figaro.env.ADMIN_EMAIL) do |user|
        user.password = Figaro.env.ADMIN_PASSWORD
        user.password_confirmation = Figaro.env.ADMIN_PASSWORD
        user.admin!
      end
  end
end
