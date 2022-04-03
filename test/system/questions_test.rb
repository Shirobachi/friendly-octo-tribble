require "application_system_test_case"

class QuestionsTest < ApplicationSystemTestCase
  setup do
    @question = questions(:one)
  end

  test "visiting the index" do
    visit questions_url
    assert_selector "h1", text: "Questions"
  end

  test "should create question" do
    visit questions_url
    click_on "New question"

    fill_in "Ansa", with: @question.ansA
    fill_in "Ansb", with: @question.ansB
    fill_in "Ansc", with: @question.ansC
    fill_in "Ansd", with: @question.ansD
    fill_in "Justification", with: @question.justification
    fill_in "Points", with: @question.points
    fill_in "Question", with: @question.question
    fill_in "Questionurl", with: @question.questionUrl
    fill_in "Time", with: @question.time
    click_on "Create Question"

    assert_text "Question was successfully created"
    click_on "Back"
  end

  test "should update Question" do
    visit question_url(@question)
    click_on "Edit this question", match: :first

    fill_in "Ansa", with: @question.ansA
    fill_in "Ansb", with: @question.ansB
    fill_in "Ansc", with: @question.ansC
    fill_in "Ansd", with: @question.ansD
    fill_in "Justification", with: @question.justification
    fill_in "Points", with: @question.points
    fill_in "Question", with: @question.question
    fill_in "Questionurl", with: @question.questionUrl
    fill_in "Time", with: @question.time
    click_on "Update Question"

    assert_text "Question was successfully updated"
    click_on "Back"
  end

  test "should destroy Question" do
    visit question_url(@question)
    click_on "Destroy this question", match: :first

    assert_text "Question was successfully destroyed"
  end
end
