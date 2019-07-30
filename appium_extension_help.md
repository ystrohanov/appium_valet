enter(<text>).into textfield: <textfield_id>

click({<text> | {button | button_contains | name | <other_selector>}: <text>})
        [.{after_wait({:no_wait | :a_little | :a_sec | :a_few | :a_bunch | :a_lot}) | eventually}]
        .on [<exception_block>]

check({<text> | {button | button_contains | name | <other_selector>}: <text>})
        [.{after_wait({:no_wait | :a_little | :a_sec | :a_few | :a_bunch | :a_lot}) | eventually}]
        .{is_displayed | is_displayed?} [<exception_block>]


<exception_block> = { |scenario|
    # do any manipulation that might make scenario pass next time, e.g. respond to popup
    # ...

    scenario.repeat
}
