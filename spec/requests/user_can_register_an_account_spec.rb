RSpec.describe 'POST /api/auth/sign_in', type: :request do
  let(:user) { create(:user) }
  let(:expected_response) do
    {
      'data' => {
        'id' => user.id, 'uid' => user.email, 'email' => user.email,
        'provider' => 'email', 'allow_password_change' => false
      }
    }
  end

  describe 'successfully with valid credentials' do
    before do
      post '/api/auth/sign_in',
           params: {
             email: user.email,
             password: user.password
           }
    end

    it 'it is expected to return 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return information about user' do
      expect(response_json).to eq expected_response
    end
  end

  describe 'unsuccessfully' do
    describe 'with invalid password' do
      before do
        post '/api/auth/sign_in',
        params: {
          email: user.email,
          password: 'WrongPassword'
        }
      end

      it 'is expected to return a 401 response status' do
        expect(response).to have_http_status 401
      end

      it 'is expected to return an error message' do
        expect(response_json['errors'].first).to eq "Invalid login credentials. Please try again."
      end
    end
  end
end
