# appium_valet
Appium ruby extension for easier use driver's functions

## Usage
```ruby
enter(<text>).into textfield: <textfield_id>

click({{<text> | {button | button_contains | name | <other_selector>}: <text> | <text>})
        [.{after_wait({:no_wait | :a_little | :a_sec | :a_few | :a_bunch | :a_lot}) | eventually}]
        .on [<exception_block>]

check({{<text> | {button | button_contains | name | <other_selector>}: <text> | <text>})
        [.{after_wait({:no_wait | :a_little | :a_sec | :a_few | :a_bunch | :a_lot}) | eventually}]
        .{is_displayed | is_displayed?} [<exception_block>]


<exception_block> = { |scenario|
    # do any manipulation that might make scenario pass next time, e.g. respond to popup
    # ...

    scenario.repeat
}
```

## Examples
```ruby
# check text is on the screen and visible
check("Username").is_displayed

# check text is on button and visible 
check(button: "Sign In").is_displayed

# check element with certain accessibility_id is displayed
check(accessibility_id: "sign_in_button_accessibility_id").is_displayed

# click on the button with provided text
click("Sign In").on

# click on any element that has provided text
click(name: "Text on any element").on

# try clickicing on the button for several seconds
click("Sign In").after_wait(:a_few).on

# wait for text to be eventually (30 seconds timeout) displayed
check("Username").eventually.is_displayed

# retry to find or click on element after making certain manipulations
click("New Feature").after_wait(:a_sec).on { |scenario|
    # check if driver is on right page and repeat, otherwise fail the test
    if check("Login page title").is_displayed?
      # it seems like we are still on Login page, try to login again and repeat
      click("Login").on
      scenario.repeat
    else
      scenario.do_not_repeat
    end
}

# enter text to textfield with specified accessibility_id
enter("anonymous").into textfield: "username_textfield"
enter("qwerty").into textfield: "password_textfield"
```
