# frozen_string_literal: true

module Mutations
  class CreateMix < Mutations::BaseMutation
    description "Create a new Mix"

    # INPUTS
    argument :title, String, required: true
    argument :dj_name, String, required: true
    argument :duration_seconds, Integer, required: true
    argument :audio_url, String, required: false
    argument :recorded_at, GraphQL::Types::ISO8601DateTime, required: false

    # OUTPUTS
    field :mix, Types::MixType, null: true
    field :errors, [ String ], null: false

    def resolve(title:, dj_name:, duration_seconds:, audio_url: nil, recorded_at: nil)
      mix = Mix.new(
        title: title,
        dj_name: dj_name,
        duration_seconds: duration_seconds,
        audio_url: audio_url,
        recorded_at: recorded_at
      )

      mix.status ||= :draft if mix.respond_to?(:status)

      if mix.save
        { mix: mix, errors: [] }
      else
        { mix: nil, errors: mix.errors.full_messages }
      end
    end
  end
end
