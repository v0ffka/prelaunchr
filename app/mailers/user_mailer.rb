class UserMailer < ActionMailer::Base
    default from: "Awanga <no-reply@awanga.fr>"

    def signup_email(user)
        @user = user
        @twitter_message = "La mode devient meilleure. J'attends le lancement d’@awangaofficial avec impatience #betterclothing"

        mail(:to => user.email, :subject => "Merci de votre inscription")
    end
end
