RSpec.describe 'POST /api/articles', type: :request do
  describe 'successfully' do
    before do
      post '/api/articles',
      params: {
        article: {
          title: 'This is an awesome title',
          body: 'This is a really interesting body!'
        }
      }
    end

    it 'is expected to return a 201 status' do
      expect(response).to have_http_status 201
    end

    it 'is expected to return a success message' do
      expect(response_json['message']).to eq 'The article was successfully saved'
    end
  end

  describe 'unsuccessfully' do
    describe 'without title' do
      before do
        post '/api/articles',
        params: {
          article: {
            title: '',
            body: 'This is a really interesting body!'
          }
        }
      end

      it 'is expected to return a 422 status' do
        expect(response).to have_http_status 422
      end

      it 'is expected to return an error message' do
        expect(response_json['message']).to eq "Title can't be blank"
      end
    end
  end
end