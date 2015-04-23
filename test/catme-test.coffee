chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'catme', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/catme')(@robot)

  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/cat( me)?$/i)

  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/cat bomb( (\d+))?/i)

  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/cat categories/i)

  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/cat( me)? (with|in)( (\w+))?/i)
