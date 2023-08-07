package com.example.train

import android.content.Context
import android.content.Intent
import android.os.Build
import android.provider.Settings
import android.util.Log
import androidx.biometric.BiometricManager
import androidx.biometric.BiometricManager.Authenticators.BIOMETRIC_STRONG
import androidx.biometric.BiometricManager.Authenticators.DEVICE_CREDENTIAL
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import androidx.fragment.app.FragmentActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.Executor


class AuthActivity(context: Context) :
    FlutterFragmentActivity() {
    private lateinit var executor: Executor
    private lateinit var promptInfo: BiometricPrompt.PromptInfo
    private var context: Context

    init {
        this.context = context
    }

    fun authenticate(methodChannel: MethodChannel, activity: FragmentActivity, auth: AuthModel) {
        executor = ContextCompat.getMainExecutor(context)

        promptInfo = BiometricPrompt.PromptInfo.Builder().setTitle(auth.title)
            .setSubtitle(auth.subTitle)
            .setConfirmationRequired(auth.confirmationRequired)
            .setDescription(auth.description)
            .setNegativeButtonText(auth.passwordButtonName).build()

        BiometricPrompt(
            activity,
            executor,
            object : BiometricPrompt.AuthenticationCallback() {
                override fun onAuthenticationError(
                    errorCode: Int, errString: CharSequence
                ) {
                    super.onAuthenticationError(errorCode, errString)
                    methodChannel.invokeMethod(
                        "error",
                        "Authentication error : $errString"
                    )
                }

                override fun onAuthenticationSucceeded(
                    res: BiometricPrompt.AuthenticationResult
                ) {
                    super.onAuthenticationSucceeded(res)
                    println(res.authenticationType)
                    methodChannel.invokeMethod("success", "Authentication succeeded!")
                }

                override fun onAuthenticationFailed() {
                    super.onAuthenticationFailed()
                    methodChannel.invokeMethod("error", "Authentication failed")
                }
            }).authenticate(promptInfo)
    }

    fun canAuthenticate(): Auth {
        val biometricManager = BiometricManager.from(context)
        when (biometricManager.canAuthenticate(BIOMETRIC_STRONG or DEVICE_CREDENTIAL)) {
            BiometricManager.BIOMETRIC_SUCCESS -> {
                Log.d("MY_APP_TAG", "App can authenticate using biometrics.")
                return Auth.CanAuthenticate
            }
            BiometricManager.BIOMETRIC_ERROR_NO_HARDWARE -> {
                Log.e("MY_APP_TAG", "No biometric features available on this device.")
                return Auth.NoHardWare
            }
            BiometricManager.BIOMETRIC_ERROR_HW_UNAVAILABLE -> {
                Log.e("MY_APP_TAG", "Biometric features are currently unavailable.")
                return Auth.UnAvailable
            }
            BiometricManager.BIOMETRIC_ERROR_NONE_ENROLLED -> {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                    val enrollIntent = Intent(Settings.ACTION_BIOMETRIC_ENROLL).apply {
                        putExtra(
                            Settings.EXTRA_BIOMETRIC_AUTHENTICATORS_ALLOWED,
                            BIOMETRIC_STRONG or DEVICE_CREDENTIAL,
                        )
                    }
                    startActivity(enrollIntent)
                    return Auth.NoneEnrolled
                }
            }
            BiometricManager.BIOMETRIC_ERROR_SECURITY_UPDATE_REQUIRED -> {
                return Auth.UnAvailable
            }
            BiometricManager.BIOMETRIC_ERROR_UNSUPPORTED -> {
                return Auth.UnAvailable
            }
            BiometricManager.BIOMETRIC_STATUS_UNKNOWN -> {
                return Auth.UnAvailable
            }
        }
        return Auth.UnAvailable
    }
}

enum class Auth {
    CanAuthenticate,
    NoHardWare,
    UnAvailable,
    NoneEnrolled,
}