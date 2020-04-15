package ng.net.cyberpay.cyberpay_flutterplugin;

import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import com.cyberspace.cyberpaysdk.CyberpaySdk;
import com.cyberspace.cyberpaysdk.TransactionCallback;
import com.cyberspace.cyberpaysdk.enums.Mode;
import com.cyberspace.cyberpaysdk.model.Booking;
import com.cyberspace.cyberpaysdk.model.Transaction;

import io.flutter.plugin.common.MethodChannel;

public class PaymentActivity extends AppCompatActivity {

    Transaction transaction;
    Booking booking;
    private String integrationKey;
    private Boolean LiveMode;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_payment);


        transaction = new Transaction();


        Intent intent = getIntent();
        if (intent.getExtras() != null) {

            Bundle b = intent.getExtras();
            booking = (Booking) intent.getSerializableExtra("bookingTransaction");
            transaction.setAmount(booking.getAmount());
            transaction.setCustomerEmail(booking.getCustomerEmail());

            integrationKey = intent.getStringExtra("integrationKey");
            LiveMode = b.getBoolean("mode");

            CyberpaySdk.INSTANCE.initialiseSdk(integrationKey, LiveMode ? Mode.Live : Mode.Debug);
            CyberpaySdk.INSTANCE.setMerchantLogo(getResources().getDrawable(R.drawable.ic_cyberpay_logo));


        }

        CyberpaySdk.INSTANCE.checkoutTransaction(this, transaction, new TransactionCallback() {
            @Override
            public void onSuccess(Transaction transaction) {
                Log.e("RESPONSE", "SUCCESSFUL");
                Toast.makeText(PaymentActivity.this, "Transaction Successful, Your Data will be Processed ", Toast.LENGTH_SHORT).show();

                Intent returnIntent = getIntent();
                returnIntent.putExtra("result", transaction.getReference());
                setResult(Activity.RESULT_OK, returnIntent);
                finish();
            }

            @Override
            public void onError(Transaction transaction, Throwable throwable) {
                Log.e("ERROR", throwable.getMessage());
                Toast.makeText(PaymentActivity.this, "CyberPay " + throwable.getMessage(), Toast.LENGTH_SHORT).show();
                finish();
            }

            @Override
            public void onValidate(Transaction transaction) {

            }
        });


    }
}
