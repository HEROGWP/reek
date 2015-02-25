require 'spec_helper'
require 'reek/smells/module_initialize'
require 'reek/smells/smell_detector_shared'

describe Reek::Smells::ModuleInitialize do
  context 'module' do
    context 'with method named initialize' do
      it 'smells' do
        src = <<-EOF
          module A
            def initialize; end
          end
        EOF
        expect(src).to reek_of(:ModuleInitialize)
      end
    end

    context 'with method named initialize in a nested class' do
      it 'does not smell' do
        src = <<-EOF
          module A
            class B
              def initialize; end
            end
          end
        EOF
        expect(src).not_to reek_of(:ModuleInitialize)
      end
    end

    context 'with method named initialize in a nested struct' do
      it 'does not smell' do
        src = <<-EOF
          module A
            B = Struct.new(:c) do
              def initialize; end
            end
          end
        EOF
        expect(src).not_to reek_of(:ModuleInitialize)
      end
    end
  end
end
