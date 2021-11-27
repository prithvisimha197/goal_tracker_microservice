# frozen_string_literal: true

require 'rails_helper'
require 'pry'

RSpec.describe 'Actions', type: :request do
  describe 'GET /index' do
    let(:mocked_response) do
      [
        {
          id: 12,
          goal: 'read',
          created_on: '2021-02-03T12:00:00.000Z',
          deadline: '2031-02-03T12:00:00.000Z',
          is_completed: false,
          completed_on: '2042-02-03T12:00:00.000Z',
          created_at: '2021-11-25T15:06:09.000Z',
          updated_at: '2021-11-25T15:06:42.000Z'
        }
      ]
    end

    before do
      allow(Action).to receive(:all).and_return(mocked_response)
    end

    it 'returns http success' do
      get '/actions'
      expect(response.body).to eq(mocked_response.to_json)
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /index' do
    let(:mocked_post) do
      {
        goal: 'read',
        created_on: '2021-02-03T12:00:00.000Z',
        deadline: '2031-02-03T12:00:00.000Z',
        is_completed: false,
        completed_on: '2042-02-03T12:00:00.000Z',
        created_at: '2021-11-25T15:06:09.000Z',
        updated_at: '2021-11-25T15:06:42.000Z'
      }
    end

    before do
      allow(Action).to receive(:create).and_return(mocked_post)
    end

    it 'returns http success' do
      post '/actions'
      expect(response.body).to eq(mocked_post.to_json)
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /show' do
    let(:mocked_response) do
      {
        id: 12,
        goal: 'read',
        created_on: '2021-02-03T12:00:00.000Z',
        deadline: '2031-02-03T12:00:00.000Z',
        is_completed: false,
        completed_on: '2042-02-03T12:00:00.000Z',
        created_at: '2021-11-25T15:06:09.000Z',
        updated_at: '2021-11-25T15:06:42.000Z'
      }
    end

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
    let(:mocked_response) do
      {
        id: 12,
        goal: 'read',
        created_on: '2021-02-03T12:00:00.000Z',
        deadline: '2031-02-03T12:00:00.000Z',
        is_completed: false,
        completed_on: '2042-02-03T12:00:00.000Z',
        created_at: '2021-11-25T15:06:09.000Z',
        updated_at: '2021-11-25T15:06:42.000Z'
      }
    end
    before do
      allow(Action).to receive(:find).and_return(mocked_response)
      allow(controller).to receive(:update).and_return(nil)
    end

    it 'returns http success' do
      put '/actions/1'
      expect(response.status).to eq(204)
    end
  end

  describe 'DELETE /destroy' do
    let(:mocked_response) do
      {
        id: 12,
        goal: 'read',
        created_on: '2021-02-03T12:00:00.000Z',
        deadline: '2031-02-03T12:00:00.000Z',
        is_completed: false,
        completed_on: '2042-02-03T12:00:00.000Z',
        created_at: '2021-11-25T15:06:09.000Z',
        updated_at: '2021-11-25T15:06:42.000Z'
      }
    end
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
