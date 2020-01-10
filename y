{
  "ignored_warnings": [
    {
      "warning_type": "Mass Assignment",
      "warning_code": 105,
      "fingerprint": "4007e7ca40e0dee4e545556b93974c54e21cad45f6cd48fe9c81fd0464896bf9",
      "check_name": "PermitAttributes",
      "message": "Potentially dangerous key allowed for mass assignment",
      "file": "app/controllers/users_controller.rb",
      "line": 48,
      "link": "https://brakemanscanner.org/docs/warning_types/mass_assignment/",
      "code": "params.require(:user).permit(:organisation_id, :role, :email, :first_name, :last_name, :biography, :twitter_handle, :facebook_handle, :linkedin_handle, :website_link, :avatar)",
      "render_path": null,
      "location": {
        "type": "method",
        "class": "UsersController",
        "method": "user_params"
      },
      "user_input": ":role",
      "confidence": "Medium",
      "note": ""
    }
  ],
  "updated": "2020-01-09 13:01:11 +0100",
  "brakeman_version": "4.7.2"
}
