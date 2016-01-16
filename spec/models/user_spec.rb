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
    describe "databse validations" do
      describe "email validations" do
        let(:user) {FactoryGirl.build(:user, :email => nil)}
        context 'when email is nil' do
          it 'raises StatementIinvalid' do
            expect { user.save!(validate: false) }.to raise_error(ActiveRecord::StatementInvalid)
          end
        end

        context 'when name is not unique' do
          let!(:user ) {FactoryGirl.create(:user, email: 'a@example.com')}
          let(:user_duplicate ) {FactoryGirl.build(:user, email: 'a@example.com')}
          it 'raises StatementIinvalid' do
            expect{user_duplicate.save!(validate:false)}.to raise_error(ActiveRecord::StatementInvalid)
          end
        end

      end

      describe "name validations" do
        let(:user) {FactoryGirl.build(:user, :name => nil)}
        context 'when name is nil' do
          it 'raises StatementIinvalid' do
            expect { user.save!(validate: false) }.to raise_error(ActiveRecord::StatementInvalid)
          end
        end

        context 'when name is not unique' do
          let!(:user ) {FactoryGirl.create(:user, name: 'dav')}
          let(:user_duplicate ) {FactoryGirl.build(:user, name: 'dav')}
          it 'raises StatementIinvalid' do
            expect{user_duplicate.save!(validate:false)}.to raise_error(ActiveRecord::StatementInvalid)
          end
        end
      end
    end

    describe 'ActiveRecord validations' do

      describe "name validations" do
        context 'when name is nil' do
          let(:user) {FactoryGirl.build(:user, name: nil)}
          it 'is invalid' do
            expect(user).to be_invalid
          end
        end

        context 'when name is blank' do
          let(:user) {FactoryGirl.build(:user, name: '')}
          it 'is invalid' do
            expect(user).to be_invalid
          end
        end

        context 'when name is not unique' do
          let!(:user ) {FactoryGirl.create(:user, name: 'dav')}
          let(:user_duplicate ) {FactoryGirl.build(:user, name: 'dav')}
          it 'is invalid' do
            expect(user_duplicate).to be_invalid
          end
        end

        context 'when name is longer than 30' do
          name = "a" * 31
          let(:user) {FactoryGirl.build(:user, name: name)}

          it 'is invalid' do
            expect(user).to be_invalid
          end
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
        expect(user.admin?).to be false
      end
    end
  end

end
