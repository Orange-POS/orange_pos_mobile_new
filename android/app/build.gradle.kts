
import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

// --------------------------------------------------
// Android release signing configuration
// --------------------------------------------------

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")

if (keystorePropertiesFile.exists()) {
    FileInputStream(keystorePropertiesFile).use {
        keystoreProperties.load(it)
    }
}

fun signingValue(
    environmentVariable: String,
    propertyName: String,
): String? {
    return System.getenv(environmentVariable)
        ?.takeIf { it.isNotBlank() }
        ?: keystoreProperties.getProperty(propertyName)
            ?.takeIf { it.isNotBlank() }
}

val releaseKeystorePath = signingValue(
    "ANDROID_KEYSTORE_PATH",
    "storeFile",
)

val releaseKeyAlias = signingValue(
    "ANDROID_KEYSTORE_ALIAS",
    "keyAlias",
)

val releaseKeyPassword = signingValue(
    "ANDROID_KEYSTORE_PRIVATE_KEY_PASSWORD",
    "keyPassword",
)

val releaseStorePassword = signingValue(
    "ANDROID_KEYSTORE_PASSWORD",
    "storePassword",
)

val hasReleaseSigning =
    releaseKeystorePath != null &&
    releaseKeyAlias != null &&
    releaseKeyPassword != null &&
    releaseStorePassword != null

// --------------------------------------------------
// Android application configuration
// --------------------------------------------------

android {
    namespace = "com.example.verygoodcore.odoo_inventory"

    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.verygoodcore.odoo_inventory"

        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion

        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // --------------------------------------------------
    // Signing configurations
    // --------------------------------------------------

    signingConfigs {
        create("release") {
            if (hasReleaseSigning) {
                storeFile = file(releaseKeystorePath!!)
                storePassword = releaseStorePassword
                keyAlias = releaseKeyAlias
                keyPassword = releaseKeyPassword
            }
        }
    }

    // --------------------------------------------------
    // Product flavors
    // --------------------------------------------------

    flavorDimensions += "default"

    productFlavors {
        create("development") {
            dimension = "default"

            applicationIdSuffix = ".dev"

            manifestPlaceholders["appName"] =
                "[DEV] Odoo Inventory"
        }

        create("staging") {
            dimension = "default"

            applicationIdSuffix = ".stg"

            manifestPlaceholders["appName"] =
                "[STG] Odoo Inventory"
        }

        create("production") {
            dimension = "default"

            applicationIdSuffix = ""

            manifestPlaceholders["appName"] =
                "Odoo Inventory"
        }
    }

    // --------------------------------------------------
    // Build types
    // --------------------------------------------------

    buildTypes {
        getByName("debug") {
            signingConfig = signingConfigs.getByName("debug")
        }

        getByName("release") {
            signingConfig = signingConfigs.getByName("release")

            isMinifyEnabled = true

            proguardFiles(
                getDefaultProguardFile("proguard-android.txt"),
                "proguard-rules.pro",
            )
        }
    }
}

// --------------------------------------------------
// Validate signing only for release builds
// --------------------------------------------------

gradle.taskGraph.whenReady {
    val releaseBuildRequested = allTasks.any {
        it.name.contains("Release", ignoreCase = false) &&
            (
                it.name.startsWith("assemble") ||
                it.name.startsWith("bundle") ||
                it.name.startsWith("package")
            )
    }

    if (releaseBuildRequested) {
        check(hasReleaseSigning) {
            """
            Android release signing configuration is missing.

            Configure signing using either:

            1. GitHub Actions environment variables:
               ANDROID_KEYSTORE_PATH
               ANDROID_KEYSTORE_ALIAS
               ANDROID_KEYSTORE_PRIVATE_KEY_PASSWORD
               ANDROID_KEYSTORE_PASSWORD

            2. Local android/key.properties file.

            Release builds require a permanent signing key.
            """.trimIndent()
        }
    }
}

// --------------------------------------------------
// Flutter configuration
// --------------------------------------------------

flutter {
    source = "../.."
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib:2.2.10")
}
