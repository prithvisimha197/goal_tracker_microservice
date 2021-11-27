# frozen_string_literal: true

# Controller to perfrom CRUD Operations for action plans.
class ActionsController < ApplicationController
  # Public: Method to fetch all the action items.
  def index
    actions = Action.all
    render json: actions, status: :ok
  end

  # Public: Method to post an action item.
  def create
    validate_body_params

    actions = Action.create(actions_permit)

    render json: actions, status: :ok
  end

  # Public: Method to fetch an action item.
  def show
    action = Action.find(params[:id])
    render json: action, status: :ok
  end

  # Public: Method to update an action item.
  def update
    validate_body_params

    action = Action.find(params[:id])
    action.update(actions_permit)

    head :no_content
  end

  # Public: Method to delete an action item.
  def destroy
    action = Action.find(params[:id])
    action.destroy

    head :no_content
  end

  private

  # Private: Method to construct post and put body based on input params.
  def actions_permit
    {
      goal: params[:goal],
      created_on: params[:created_on],
      deadline: params[:deadline] || nil,
      is_completed: params[:is_completed],
      completed_on: params[:completed_on] || nil
    }
  end

  # Private: Method to validate params before performing POST or PUT calls.
  def validate_body_params
    if actions_permit[:is_completed] == false && actions_permit[:completed_on].present?
      raise ActionController::BadRequest.new,
            'Completed Date cannot be present if is_completed is set to false'
    end

    if !actions_permit[:deadline].nil? &&
       (actions_permit[:deadline] < actions_permit[:created_on])
      raise ActionController::BadRequest.new, 'Deadline must be greater than the created date'
    end

    (if !actions_permit[:completed_on].nil? &&
      (actions_permit[:completed_on] < actions_permit[:created_on])
       raise ActionController::BadRequest.new,
             'Completed Date must be greater than the created date'
     end)
  end
end
