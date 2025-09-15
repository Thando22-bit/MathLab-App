plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android") // ✅ correct Kotlin plugin
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // ✅ Firebase
}

android {
    namespace = "com.example.skrola"
    compileSdk = 35
    ndkVersion = "27.3.13750724"

    compileOptions {
        // ✅ Upgrade to Java 17
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17" // ✅ Set Kotlin to Java 17
    }

    defaultConfig {
        applicationId = "com.example.skrola"
        minSdk = 23
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // ✅ Firebase BoM (manages versions automatically)
    implementation(platform("com.google.firebase:firebase-bom:34.0.0"))

    // ✅ Firebase SDKs
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")
    implementation("com.google.firebase:firebase-storage")
}

