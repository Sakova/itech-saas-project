// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

let colors = [
    "btn-primary",
    "btn-secondary",
    "btn-success",
    "btn-danger",
    "btn-warning text-dark",
];

document.addEventListener("turbolinks:load", function() {
    $(document).ready(function () {
        $('.sign-up-btn').on('click', function (event) {
            event.preventDefault();
            let $form = $('#new_user');
            $form.find("input[type=submit]").prop("disabled", true);
            let user_email = $form.find('input[name="user[email]"]').val();
            let user_password = $form.find('input[name="user[password]"]').val();
            let user_password_confirmation = $form.find('input[name="user[password_confirmation]"]').val();
            let user_organization_name = $form.find('input[name="organization[name]"]').val();
            let user_organization_plan = $form.find('select[name="organization[plan]"]').val();

            $.ajax({
                url: "/users",
                type: "post",
                dataType: 'json',
                contentType: "application/json",
                data: JSON.stringify({
                    user: {
                        email: user_email,
                        password: user_password,
                        password_confirmation: user_password_confirmation
                    },
                    organization: {
                        name: user_organization_name,
                        plan: user_organization_plan
                    },
                }),
                success: function (data) {
                    console.log(data)
                    if (data.plan == 'premium') {
                        $.ajax({
                            url: "/checkout/create",
                            type: "post",
                            contentType: "application/json",
                            data: JSON.stringify({
                                data_for_stripe: {
                                    stripe_customer_id: data.stripe_id
                                }
                            }),
                            success: function (data) {
                                console.log('success');
                            },
                            error: function (data) {
                                console.log('error');
                            }
                        })
                    } else {
                        document.location.href = '/?notice=true';
                    }
                },
                error: function (data) {
                    console.log('error');
                }
            })
        });
        if(window.location.search === "?plan=premium") {
            $('select>option:eq(2)').attr('selected', true);
        } else if(window.location.search === "?plan=free") {
            $('select>option:eq(1)').attr('selected', true);
        }

        ( () => {
            function changeColors() {
                if (document.getElementById("premium") != null) {
                    let num = Math.floor(Math.random() * 5);
                    document.getElementById(
                        "premium"
                    ).className = `btn ${colors[num]} me-5`;
                    setTimeout(() => {
                        changeColors();
                    }, 10000);
                }
            }
            changeColors();
        } )();
    });
});
