class EchoRequest
  attr_reader :version, :session, :request

  def initialize params
    @version = params.fetch 'version'
    @session = params.fetch 'session'
    @request = params.fetch 'request'
  end

  def response
    case request_type
    when 'LaunchRequest'
      application_start_response
    when 'IntentRequest'
      application_intent_response
    else
      application_end_response
    end
  end

  private

  def user_name
    ECHO_CONFIG[:name]
  end

  def request_type
    request.fetch('type')
  end

  def application_start_response
    { version: '1.0',
      response: {
        outputSpeech: {
          type: 'PlainText',
          text: "Welcome to your Nest Thermostat #{user_name}, what would you like to do?"
        },
        reprompt: {
          outputSpeech: {
            type: 'PlainText',
            text: 'You can ask me what the current temperature is, for instance.'
          }
        },
        shouldEndSession: false
      }
    }.to_json
  end

  def application_intent_response
    current_temperature = 74.23.round.humanize.gsub('-',' ')
    { version: '1.0',
      response: {
        outputSpeech: {
          type: 'PlainText',
          text: "The current temperature in your home is #{current_temperature}."
        },
        shouldEndSession: true
      }
    }.to_json
  end

  def application_end_response
    { version: '1.0',
      response: {
        outputSpeech: {
          type: 'PlainText',
          text: "Thanks for using your Nest Thermostat #{user_name}, goodbye."
        },
        shouldEndSession: true
      }
    }.to_json
  end
end
