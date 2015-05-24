require 'test_helper'

class PeriodicEventsControllerTest < ActionController::TestCase
  setup do
    @periodic_event = periodic_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:periodic_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create periodic_event" do
    assert_difference('PeriodicEvent.count') do
      post :create, periodic_event: { end: @periodic_event.end, eventType: @periodic_event.eventType, periodicity: @periodic_event.periodicity, start: @periodic_event.start, user_id: @periodic_event.user_id }
    end

    assert_redirected_to periodic_event_path(assigns(:periodic_event))
  end

  test "should show periodic_event" do
    get :show, id: @periodic_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @periodic_event
    assert_response :success
  end

  test "should update periodic_event" do
    patch :update, id: @periodic_event, periodic_event: { end: @periodic_event.end, eventType: @periodic_event.eventType, periodicity: @periodic_event.periodicity, start: @periodic_event.start, user_id: @periodic_event.user_id }
    assert_redirected_to periodic_event_path(assigns(:periodic_event))
  end

  test "should destroy periodic_event" do
    assert_difference('PeriodicEvent.count', -1) do
      delete :destroy, id: @periodic_event
    end

    assert_redirected_to periodic_events_path
  end
end
