require File.expand_path(__FILE__ + '/../../spec_helper')

describe "Window Selection" do

  it "Selects and close popup windows " do
    selenium_driver.start_new_browser_session
    page.open "http://localhost:4444/selenium-server/tests/html/test_select_window.html"
    page.click "popupPage"
    page.wait_for_popup "myPopupWindow"
    page.select_window "name=myPopupWindow"
    page.location.should =~ %r{/tests/html/test_select_window_popup.html}
    page.title.should =~ /Select Window Popup/
    page.get_all_window_names.size.should eql(2)
    page.get_all_window_names.include?("myPopupWindow").should be_true
    page.close
    page.select_window "null"
    page.location.should =~ %r{/tests/html/test_select_window.html}
    page.click "popupPage"
    page.wait_for_pop_up "myPopupWindow", "5000"
    page.select_window "title=Select Window Popup"
    page.location.should =~ %r{/tests/html/test_select_window_popup.html}
    page.close
    page.select_window "null"
  end

  it "Select an anonymous window (one that isn't assigned to a variable)" do
    selenium_driver.start_new_browser_session
    page.open "http://localhost:4444/selenium-server/tests/html/test_select_window.html"
    page.click "popupAnonymous"
    page.wait_for_popup "anonymouspopup"
    page.select_window "anonymouspopup"
    page.location.should =~ %r{/tests/html/test_select_window_popup.html}
    page.click "closePage"
    page.select_window "null"    
  end

  it "Try onclick close handler" do
    selenium_driver.start_new_browser_session
    page.open "http://localhost:4444/selenium-server/tests/html/test_select_window.html"
    page.click "popupAnonymous"
    page.wait_for_popup "anonymouspopup"
    page.select_window "anonymouspopup"
    page.location.should =~ %r{/tests/html/test_select_window_popup.html}
    page.click "closePage2"
  end
  
end
