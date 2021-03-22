# frozen_string_literal: true

class HelloWorldController < ApplicationController
  resource_description do
    description <<-END_OF_TEXT
    == Description
      This endpoint will create an Applicant and associate it with
      an existing Assessment which has been created with:

        GET /hello_world

    END_OF_TEXT
  end
  api :GET, 'hello_world', 'Returns Hello World in a JSON structure'
  formats(%w[json])

  returns code: :ok, desc: 'Successful response' do
    property :success, ['true'], desc: 'Success flag shows true'
    property :errors, [], desc: 'Empty array of error messages'
  end

  returns code: :unprocessable_entity do
    property :success, ['false'], desc: 'Success flag shows false'
    property :errors, array_of: String, desc: 'Description of why object invalid'
  end

  def show
    render json: hello_world_struct
  end

  private

  def hello_world_struct
    {
      success: true,
      message: 'Hello World'
    }
  end
end
