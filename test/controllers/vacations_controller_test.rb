require "test_helper"

class VacationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vacation = vacations(:one)
  end

  test "should get index" do
    get vacations_url
    assert_response :success
  end

  test "should get new" do
    get new_vacation_url
    assert_response :success
  end

  test "should create vacation" do
    assert_difference('Vacation.count') do
      post vacations_url, params: { vacation: { email: @vacation.email, employee_name: @vacation.employee_name, end_date: @vacation.end_date, leader: @vacation.leader, reason: @vacation.reason, start_date: @vacation.start_date, state: @vacation.state, type: @vacation.type } }
    end

    assert_redirected_to vacation_url(Vacation.last)
  end

  test "should show vacation" do
    get vacation_url(@vacation)
    assert_response :success
  end

  test "should get edit" do
    get edit_vacation_url(@vacation)
    assert_response :success
  end

  test "should update vacation" do
    patch vacation_url(@vacation), params: { vacation: { email: @vacation.email, employee_name: @vacation.employee_name, end_date: @vacation.end_date, leader: @vacation.leader, reason: @vacation.reason, start_date: @vacation.start_date, state: @vacation.state, type: @vacation.type } }
    assert_redirected_to vacation_url(@vacation)
  end

  test "should destroy vacation" do
    assert_difference('Vacation.count', -1) do
      delete vacation_url(@vacation)
    end

    assert_redirected_to vacations_url
  end
end
