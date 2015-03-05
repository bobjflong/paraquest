require 'rspec'
require File.expand_path("../../lib/paraquest/context", __FILE__)

module Paraquest
  describe Context do
    let(:variables) do
      {
        'foo' => 'bar',
        'baz' => {
          'bing' => 'baroo'
        }
      }
    end
    let(:value_params) do
      {
        'baz' => '$foo'
      }
    end
    let(:key_params) do
      {
        '$foo' => 'baz'
      }
    end
    let(:nested_params) do
      {
        'foo' => {
          '$foo' => 'baz'
        }
      }
    end
    let(:no_sub_params) do
      {
        'foo' => {
          'bar' => 'baz'
        }
      }
    end
    let(:nested_context_params) do
      {
        '$baz__bing' => 'yahoo'
      }
    end
    let(:bad_nested_context_params) do
      {
        '$baz__boo' => 'yahoo'
      }
    end
    subject(:context) { Context.new(variables) }

    context '#substitute' do
      it 'works for values' do
        expect(context.substitute(value_params)).to eq(
          'baz' => 'bar'
        )
      end

      it 'works for keys' do
        expect(context.substitute(key_params)).to eq(
          'bar' => 'baz'
        )
      end

      it 'works for nested params' do
        expect(context.substitute(nested_params)).to eq(
          'foo' => {
            'bar' => 'baz'
          }
        )
      end

      it 'works for nested contexts' do
        expect(context.substitute(nested_context_params)).to eq(
          'baroo' => 'yahoo'
        )
      end

      it 'produces good error messages for nested contexts' do
        expect { context.substitute(bad_nested_context_params) }.to raise_error(
          ParaquestNameError, 'baz__< boo >'
        )
      end

      it 'leaves things alone' do
        expect(context.substitute(no_sub_params)).to eq no_sub_params
      end
    end
  end
end
