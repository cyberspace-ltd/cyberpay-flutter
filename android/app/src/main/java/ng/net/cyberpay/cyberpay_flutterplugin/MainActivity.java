package ng.net.cyberpay.cyberpay_flutterplugin;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import java.util.Map;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import com.cyberspace.cyberpaysdk.model.Booking;
import com.cyberspace.cyberpaysdk.model.Transaction;


public class MainActivity extends FlutterActivity {

    Booking transaction;

    private String CHANNEL = "com.startActivity/testChannel";
    MethodChannel methodChannel;

    int RESULT_CODE = 1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        transaction = new Booking();

        methodChannel = new MethodChannel(getFlutterView(), CHANNEL);
        methodChannel.setMethodCallHandler((call, result) -> {
            switch (call.method) {
                case "chargeCard":

                    final Map arguments = call.arguments();
                    String integrationKey = (String) arguments.get("integrationKey");
                    Boolean liveMode = (Boolean) arguments.get("liveMode");

                    transaction.setAmount((Double) arguments.get("amount"));
                    transaction.setCustomerEmail((String) arguments.get("customerEmail"));


                    Intent intent = new Intent(
                            MainActivity.this, PaymentActivity.class);
                    intent.putExtra("bookingTransaction", transaction);
                    intent.putExtra("integrationKey", integrationKey);
                    intent.putExtra("mode", liveMode);

                    startActivityForResult(intent, RESULT_CODE);
                    //result.success("SUCCESS");

                default:
                    result.notImplemented();
            }
        });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == RESULT_CODE) {
            if (resultCode == Activity.RESULT_OK) {
                String result = data.getStringExtra("result");
                methodChannel.invokeMethod("onSuccess", result);
            }
        }
        super.onActivityResult(requestCode, resultCode, data);
    }
}

