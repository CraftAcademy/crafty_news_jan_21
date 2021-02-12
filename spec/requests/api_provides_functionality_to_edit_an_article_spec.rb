RSpec.describe 'PUT /api/articles/:id' do
  let(:article) { create(:article) }
  describe 'successfully' do
    before do
      put "/api/articles/#{article.id}",
      params: {
        article: {
          title: 'This is a new interesting title'
        }
      }
    end

    it 'is expected to return a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return a success message' do
      expect(response_json['message']).to eq 'The article was successfully updated'
    end

    it 'is expected to have updated the articles title' do
      expect(article.reload.title).to eq 'This is a new interesting title'
    end
  end

  describe 'unsuccessfully' do
    describe 'by updating none excisting resource' do
      before do
        put "/api/articles/abc"
      end
      it 'is expected to return a 404 status' do
        expect(response).to have_http_status 404
      end

      it 'is expected to return error message' do
        expect(response_json['message']).to eq "Couldn't find Article with 'id'=abc"
      end
    end

    describe 'by sending in invalid params' do
      before do
        put "/api/articles/#{article.id}",
        params: {
          title: 'This is a new title'
        }
      end

      it 'is expected to return a 422 response status' do
        expect(response).to have_http_status 422
      end

      it 'is expected to return error message' do
        expect(response_json['message']).to eq "Something went wrong, param is missing or the value is empty: article"
      end
    end
  end
end