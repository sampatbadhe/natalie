module Natalie
  class Compiler2
    class InstructionManager
      def initialize(instructions)
        @instructions = instructions
        @ip = 0
      end

      attr_accessor :ip

      def walk
        while @ip < @instructions.size
          instruction = self.next
          yield instruction
        end
        @instructions
      end

      def next
        instruction = @instructions[@ip]
        @ip += 1
        instruction
      end

      def fetch_block(until_instruction: EndInstruction, expected_label: nil)
        instructions = []

        instruction = nil
        loop do
          raise 'ran out of instructions' if @ip >= @instructions.size

          instruction = @instructions[@ip]
          @ip += 1

          instructions << instruction
          break if instruction.is_a?(until_instruction)

          instructions += fetch_block(expected_label: instruction.label) if instruction.has_body?
        end

        unless expected_label.nil? || instruction.matching_label == expected_label
          raise "unexpected instruction (expected: #{expected_label}, actual: #{instruction.matching_label})"
        end

        instructions
      end
    end
  end
end
