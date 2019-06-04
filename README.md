# yakaa

This gem is used to accept and receive payments from [Yandex Kassa](https://kassa.yandex.ru/docs/checkout-api/?shell).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yaka'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yaka

## Usage

1. Attach gem for your project
2. Create initializer for your project that will set `shop_id` and `private_key`.
    ```ruby
    # yaka.rb
     
    Yaka.config.shop_id = ENV['YANDEX_SHOP_ID']
    Yaka.config.private_key = ENV['YANDEX_PRIVATE_KEY']
    ```
3. Create payment at client side:
    ```html
        <script src="https://static.yandex.net/checkout/js/v1/"></script>
         <script src="https://static.yandex.net/checkout/ui/v1/"></script>
         <button class="btn" onclick="$checkout.open()">Pay 100</button>
         <script>
           const $checkout = YandexCheckoutUI(<%= Yaka.config.shop_id %>, {amount: 100});
           $checkout.on('yc_success', function(response) {
             $.ajax({
               url: "/route_for_yandex_kassa",
               type: 'POST',
               dataType: "json",
               contentType: "application/json; charset=utf-8",
               data: JSON.stringify({
                 redirect_url: 'https://example.com',
                 token: response.data.response.paymentToken,
                 amount: 100,
                 json_data: {ololo: 4}
               })
             }).then(x => {
                 if (x.status === "succeeded") {
                   $checkout.chargeSuccessful();
                 } else {
                   if (x.status === "pending") {
                     window.location = x.confirmation.confirmation_url;
                   } else {
                     $checkout.chargeFailful();
                   }
                 }
               }
             );
           });
    ```
4. Create payment at backend side:
    
    Token is received from front-end(`token` from the code above).
    ```ruby
    payment = Yaka::Payment.new(amount: params[:amount], description: "Пополнение счета через карту", payment_token: params[:token], metadata: params[:json_data], client_ip: request.remote_ip, confirmation: { type: "redirect", return_url: params[:redirect_url]})
    response = Yaka.publish_payment(payment, SecureRandom.uuid)
    ```
    If payment is successful - you will receive status `succeeded`. 
    If pending - in `confirmation.confirmation_url` you will have a 3ds confirmation URL. Use it!
     
5. Then you will receive a callback about payment attempt(callback is configured at yandex site).

    You can use `Yaka.yandex_ip?(ip)` to check remote ip of received request to avoid scams and cheatings.
    

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/yaka. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the yaka project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/yaka/blob/master/CODE_OF_CONDUCT.md).
