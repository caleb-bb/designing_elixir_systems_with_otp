defmodule Mastery.Core.Response do
  # This implements CORE functionality. Notice that we don't implement any of
  # this with e.g. a GenServer. Core functionality should be pure, while
  # processes deal with state. Thus, a core module should not deal with state.
  # Generally speaking, we want to use processes to control execution, divide
  # work, or store common state. Dividing work can be done by spinning up a lot
  # of processes and having them solve a problem concurrently.
  defstruct ~w[quiz_title template_name to email answer correct timestamp]a

  def new(quiz, email, answer) do
    question = quiz.current_question
    template = question.template

    %__MODULE__{
      quiz_title: quiz.title,
      template_name: template.name,
      to: question.asked,
      email: email,
      answer: answer,
      correct: template.checker.(question.subsittutions, answer),
      timestamp: DateTime.utc_now()
    }
  end
end
