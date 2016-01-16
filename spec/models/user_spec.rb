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
  describe "invalid user" do
    context "databse validations" do
      let(:user) {FactoryGirl.build(:user, :name => nil)}

      context 'when name is nil' do
        it 'should raise StatementIinvalid' do
          expect { user.save!(validate: false) }.to raise_error(ActiveRecord::StatementInvalid)
        end
      end

      context 'when name is not unique' do
        let(:user ) {FactoryGirl.create(:user, name: 'dav')}
        let(:user_duplicate ) {FactoryGirl.build(:user, name: 'dav')}
        it 'is invalid' do
          expect{user.save!(validates:false)}.not_to raise_error
          expect{user_duplicate.save!(validates:false)}.to raise_error(ActiveRecord::StatementInvalid)
        end
      end
    end

    context 'when ActiveRecord validations' do
      context 'when name is nil' do
        it 'should be invalid' do
          expect { user.save!(validate: false) }.to raise_error(ActiveRecord::StatementInvalid)
        end
      end

      context 'when name is not unique' do
        let(:user ) {FactoryGirl.create(:user, name: 'dav')}
        let(:user_duplicate ) {FactoryGirl.build(:user, name: 'dav')}
        it 'is invalid' do
          expect{user.save!(validates:false)}.not_to raise_error
          expect{user_duplicate.save!(validates:false)}.to raise_error(ActiveRecord::StatementInvalid)
        end
      end
    end

  end

  it { should respond_to(:email) }

  it {should respond_to(:role)}
  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

  describe "#set_default_role" do
    context 'when first created' do
      let (:user) {FactoryGirl.create(:user)}
      it 'is assigned guest role' do
        expect(user.guest?).to be true
      end
    end
  end

end
