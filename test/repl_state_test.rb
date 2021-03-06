# frozen_string_literal: true
# encoding: UTF-8

require 'minitest/autorun'
require_relative '../lib/fir/repl_state'
require_relative '../lib/fir/lines'
require_relative '../lib/fir/cursor'
require_relative './state_helper'
require_relative './double/key_command'
require_relative './key_command/key_command_interface_test'

describe Fir::ReplState do
  describe 'self.blank' do
    it 'creates a blank collection' do
      @collection = Fir::ReplState.blank
      @collection.lines.must_equal(Fir::Lines.blank)
      @collection.cursor.must_equal(Fir::Cursor.blank)
      @collection.blank?.must_equal(true)
    end
  end

  describe 'self.build' do
    it 'builds lines and cursor from array arguments' do
      @collection = StateHelper.build([[]], [0, 0])
      @collection.lines.must_equal(Fir::Lines.blank)
      @collection.cursor.must_equal(Fir::Cursor.blank)
    end
  end

  describe 'initialization' do
    it 'sets members instance variable correctly with arguments' do
      @collection = Fir::ReplState.new(Fir::Lines.blank,
                                       Fir::Cursor.blank,
                                       binding)
      @collection.lines.must_equal(Fir::Lines.blank)
      @collection.cursor.must_equal(Fir::Cursor.blank)
      @collection.indents.must_equal([0])
    end
  end

  describe 'clone' do
    it 'clones the cursor and lines' do
      @collection = Fir::ReplState.blank
      @new_collection = @collection.clone
      @new_collection.lines.must_equal(@collection.lines)
      @new_collection.cursor.must_equal(@collection.cursor)
      @new_collection.object_id.wont_equal(@collection.object_id)
    end
  end

  describe 'blank' do
    it 'creates a new state with blank lines and a blank cursor' do
      @collection = Fir::ReplState.blank
      @new_collection = @collection.blank
      @new_collection.lines.must_equal(Fir::Lines.blank)
      @new_collection.cursor.must_equal(Fir::Cursor.blank)
      @new_collection.object_id.wont_equal(@collection.object_id)
    end
  end

  describe 'clean' do
    it 'returns a blank state if the original state is a block' do
      @state = StateHelper.build([%w[d e f c o w], %w[e n d], ['']], [3, 1])
      @command = Double::KeyCommand.new(@state)
      @new_state = @state.transition(@command)
      @new_state.must_equal(Fir::ReplState.blank)
    end
  end

  describe 'blank?' do
    it 'returns true when the state has a blank cursor and lines' do
      @collection = Fir::ReplState.blank
      @collection.blank?.must_equal(true)
    end
  end

  describe 'executable?' do
    it 'returns true when indents indicate an executable chunk of code' do
      @collection = Fir::ReplState.blank
      @collection.executable?.must_equal(false)
      @another_collection = StateHelper.build(
        [%w[d e f c o w], %w[e n d], ['']],
        [3, 1]
      )
      @another_collection.executable?.must_equal(true)
    end
  end

  describe '==' do
    it 'returns true with two equivalent states' do
      @collection = Fir::ReplState.blank
      @new_collection = Fir::ReplState.blank
      @collection.must_equal(@new_collection)
    end
  end
end
