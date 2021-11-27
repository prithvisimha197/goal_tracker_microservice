# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Actions', type: :request do
  let(:body_params) do
    {
      goal: 'read',
      created_on: '2021-02-03T12:00:00.000Z',
      deadline: '2031-02-03T12:00:00.000Z',
      is_completed: true,
      completed_on: '2042-02-03T12:00:00.000Z'
    }
  end

  let(:mocked_response) do
    {
      id: 12,
      goal: 'read',
      created_on: '2021-02-03T12:00:00.000Z',
      deadline: '2031-02-03T12:00:00.000Z',
      is_completed: true,
      completed_on: '2042-02-03T12:00:00.000Z',
      created_at: '2021-11-25T15:06:09.000Z',
      updated_at: '2021-11-25T15:06:42.000Z'
    }
  end

  describe 'GET /index' do
    before do
      allow(Action).to receive(:all).and_return([mocked_response])
    end

    it 'returns http success' do
      get '/actions'
      expect(response.body).to eq([mocked_response].to_json)
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /index' do
    before do
      allow(Action).to receive(:create).and_return(mocked_response)
    end

    context 'when the parameters passed are valid' do
      it 'returns http success' do
        post '/actions', params: body_params, as: :json
        expect(response.body).to eq(mocked_response.to_json)
        expect(response.status).to eq(200)
      end
    end

    context 'when is_completed is set to false and completed date is passed' do
      let(:invalid_body) do
        {
          goal: 'read',
          created_on: '2021-02-03T12:00:00.000Z',
          deadline: '2031-02-03T12:00:00.000Z',
          is_completed: false,
          completed_on: '2042-02-03T12:00:00.000Z'
        }
      end

      it 'raises Bad Request Error' do
        expect do
          post '/actions', params: invalid_body, as: :json
        end.to raise_error(ActionController::BadRequest)
      end
    end

    context 'when created date is greater than the deadline' do
      let(:invalid_body) do
        {
          goal: 'read',
          created_on: '2021-02-03T12:00:00.000Z',
          deadline: '2011-02-03T12:00:00.000Z',
          is_completed: true,
          completed_on: '2042-02-03T12:00:00.000Z'
        }
      end

      it 'raises Bad Request Error' do
        expect do
          post '/actions', params: invalid_body, as: :json
        end.to raise_error(ActionController::BadRequest)
      end
    end

    context 'when created date is greater than the completed date' do
      let(:invalid_body) do
        {
          goal: 'read',
          created_on: '2021-02-03T12:00:00.000Z',
          deadline: '2031-02-03T12:00:00.000Z',
          is_completed: true,
          completed_on: '2011-02-03T12:00:00.000Z'
        }
      end

      it 'raises Bad Request Error' do
        expect do
          post '/actions', params: invalid_body, as: :json
        end.to raise_error(ActionController::BadRequest)
      end
    end
  end

  describe 'GET /show' do
    before do
      allow(Action).to receive(:find).and_return(mocked_response)
    end

    it 'returns http success' do
      get '/actions/1'
      expect(response.body).to eq(mocked_response.to_json)
      expect(response.status).to eq(200)
    end
  end

  describe 'PUT /update' do
    before do
      allow(Action).to receive(:find).and_return(mocked_response)
      allow(controller).to receive(:update).and_return(nil)
    end

    it 'returns http success' do
      put '/actions/1', params: body_params, as: :json
      expect(response.status).to eq(204)
    end
  end

  describe 'DELETE /destroy' do
    before do
      allow(Action).to receive(:find)
        .and_return(JSON.parse(mocked_response.to_json, object_class: OpenStruct))
      allow(controller).to receive(:destroy).and_return(nil)
    end

    it 'returns http success' do
      delete '/actions/1'
      expect(response.status).to eq(204)
    end
  end
end
