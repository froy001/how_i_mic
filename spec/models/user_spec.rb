describe User do

  before(:each) { @user = User.new(email: 'user@example.com') }

  subject { @user }

  it "has a valid factory" do
    user = FactoryGirl.create(:user)
    expect(user).to be_valid
  end

  # it "should reference many message_export_requests" do
  #   relation = Api::V1::User.relations['message_export_requests']
  #   expect(relation).to_not be_nil
  #   expect(relation.name).to eq(:message_export_requests)
  #   expect(relation.klass).to eq(Api::V1::MessageExportRequest)
  #   expect(relation.relation).to eq(Mongoid::Relations::Referenced::Many)
  # end

  it { should respond_to(:email) }

  it {should respond_to(:role)}
  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

  describe "#set_default_role" do
    let(:user) {}
  end

end
