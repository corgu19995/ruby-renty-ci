class ValidateToken

    def firebase(token)
        url = "https://www.googleapis.com/identitytoolkit/v3/relyingparty/getAccountInfo?key=AIzaSyBYHpRerd0Dit9PnuF8e4JcxSj34fZqPbw"
        firebase_verification_call = HTTParty.post(url, 
            headers: { 'Content-Type' => 'application/json' }, 
            body: { 'idToken' => token }.to_json )

        if firebase_verification_call.response.code == "200"
            firebase_infos = firebase_verification_call.parsed_response
            firebase_infos = firebase_infos["users"][0]["localId"]
        else
            firebase_infos = firebase_verification_call.parsed_response 
            firebase_infos = ""
        end
    end
end