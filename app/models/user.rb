class User < ActiveRecord::Base
    belongs_to :referrer, :class_name => "User", :foreign_key => "referrer_id"
    has_many :referrals, :class_name => "User", :foreign_key => "referrer_id"
    
    attr_accessible :email

    validates :email, :uniqueness => true, :format => { :with => /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i, :message => "Invalid email format." }
    validates :referral_code, :uniqueness => true

    before_create :create_referral_code
    after_create :send_welcome_email

    REFERRAL_STEPS = [
        {
            'count' => 5,
            "html" => "10%",
            "class" => "two",
            "tooltip" =>  "BIEN JOUÉ !<br><br>
CONTINUEZ
COMME ÇA, THE SKY
IS THE LIMIT !"
        },
        {
            'count' => 10,
            "html" => "20%",
            "class" => "three",
            "tooltip" => "GÉNIAL !<br><br>
ALLEZ ON SE
MOTIVE,
20% C’EST BIEN MAIS
30% C’EST TOP !"
        },
        {
            'count' => 25,
            "html" => "30%",
            "class" => "four",
            "tooltip" => "FORMIDABLE !<br><br>
ENCORE UN
DERNIER EFFORT ET
C’EST LE JACKPOT !"
        },
        {
            'count' => 50,
            "html" => "50%",
            "class" => "five",
            "tooltip" => "MAGNIFIQUE !<br><br>
UN GRAND MERCI !"
        }
    ]

    private

    def create_referral_code
        referral_code = SecureRandom.hex(5)
        @collision = User.find_by_referral_code(referral_code)

        while !@collision.nil?
            referral_code = SecureRandom.hex(5)
            @collision = User.find_by_referral_code(referral_code)
        end

        self.referral_code = referral_code
    end

    def send_welcome_email
        UserMailer.delay.signup_email(self)
    end
end
