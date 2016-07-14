function deactivate-mfa --argument user
    trace (status --current-filename) $argv

    if empty "$user"
        usage deactivate-mfa '<user>'
        return (false)
    end

    aws iam deactivate-mfa-device --user-name "$user" --serial-number (mfa-serial "$user")
end
