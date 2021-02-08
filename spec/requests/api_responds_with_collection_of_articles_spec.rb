RSpec.describe 'GET /api/articles', type: :request do
  describe 'successfully' do
    let!(:articles) { 3.times { create(:article, title: 'This is an awesome title') } }

    before do
      get '/api/articles'
    end

    it 'is expected to return a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return all articles' do
      expect(response_json['articles'].count).to eq 3
    end

    it 'is expected to turn thr articles titles' do
      expect(response_json['articles'].first['title']).to eq 'This is an awesome title'
    end
  end
end
