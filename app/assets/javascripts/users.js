$(document).ready(function() {
    
    $('#new_user')
        .formValidation({
            framework: 'bootstrap',
            icon: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                'user[name]': {
                    validators: {
                        notEmpty: {
                            message: 'Name is required'
                        }
                    }
                },
                
                'user[email]': {
                    validators: {
                        notEmpty: {
                            message: 'Email address is required'
                        },
                        emailAddress: {
                            message: 'The input is not a valid email address'
                        }
                    }
                },
                'user[password]': {
                    validators: {
                        notEmpty: {
                            message: 'Password is required'
                        },
                        stringLength: {
                            min: 6,
                            message: 'Password must be six or more characters'
                        }
                    }
                },
                'user[password_confirmation]': {
                    validators: {
                        notEmpty: {
                            message: 'Password Confirmation is required'
                        },
                        identical: {
                            field: 'user[password]',
                            message: 'Confirmed Password must match Password'

                        }
                    }
                },
               
            }
        }
        );
});