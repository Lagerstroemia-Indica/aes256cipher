package com.donguran.aes256cipher

import android.annotation.SuppressLint
import android.util.Base64
import java.security.SecureRandom
import java.security.spec.AlgorithmParameterSpec
import javax.crypto.Cipher
import javax.crypto.spec.IvParameterSpec
import javax.crypto.spec.SecretKeySpec

@Suppress("NAME_SHADOWING")
@SuppressLint("SimpleDateFormat")
object AES256Cipher {
    fun encrypt(params: Map<String, Any?>): String {
        val aesKey: String = params[Constant.paramKey]!! as String
        val data: String = params[Constant.paramData]!! as String
        val ivSpecSize: Int = 16
        // Decision 'iv' availability
        // default: true
        val ivSpecUse: Boolean = params[Constant.paramIvSpec]!! as Boolean
        val transformation: String = params[Constant.paramTransformation]!! as String

        return try {
            val textBytes:ByteArray = data.toByteArray(Charsets.UTF_8)

            // Create IV
            val iv = createIvSpecByteArray(size = ivSpecSize)

            // iv not used,
            if (ivSpecUse) {
                SecureRandom().nextBytes(iv)
            }

            val ivSpec: AlgorithmParameterSpec = IvParameterSpec(iv)
            val newKey: SecretKeySpec = SecretKeySpec(aesKey.toByteArray(Charsets.UTF_8), "AES")
            val cipher: Cipher = Cipher.getInstance(transformation)

            // Init Encrypt
            cipher.init(Cipher.ENCRYPT_MODE, newKey, ivSpec)

            // Encrypt
            val encryptedBytes: ByteArray = cipher.doFinal(textBytes)

            // Combine IV + encryptedBytes
            val ivAndCipherText = if (ivSpecUse) {
                iv + encryptedBytes
            } else {
                encryptedBytes
            }

            Base64.encodeToString(ivAndCipherText, Base64.NO_WRAP)
        } catch (e: Exception) {
            e.printStackTrace()
            e.message!!
        }
    }

    fun decrypt(params: Map<String, Any?>): String {
        val aesKey: String = params[Constant.paramKey]!! as String
        val data: String = params[Constant.paramData]!! as String
        val ivSpecUse = params[Constant.paramIvSpec]!! as Boolean
        val ivSpecSize: Int = if (ivSpecUse)  16 else 0;
        val transformation: String = params[Constant.paramTransformation]!! as String

        return try {
            // Decode
            val textBytes:ByteArray = Base64.decode(data, Base64.DEFAULT)   // Base64.DEFAULT = 0

            // IV
            val iv: ByteArray = if (ivSpecUse) textBytes.copyOfRange(0, ivSpecSize) else createIvSpecByteArray(16)
            val cipherText: ByteArray = textBytes.copyOfRange(ivSpecSize, textBytes.size)

            val ivSpec: AlgorithmParameterSpec = IvParameterSpec(iv)
            val newKey: SecretKeySpec = SecretKeySpec(aesKey.toByteArray(Charsets.UTF_8), "AES")
            val cipher: Cipher = Cipher.getInstance(transformation)

            // Init Decrypt
            // throw Error
            cipher.init(Cipher.DECRYPT_MODE, newKey, ivSpec)

            // Decode
            val decryptedBytes: ByteArray = cipher.doFinal(cipherText)
            String(decryptedBytes, Charsets.UTF_8)
        } catch (e: Exception) {
            // e.printStackTrace()
            // e.message!!
            "BAD_DECRYPT: Please check again your 'aesKey'"
        }
    }

    private fun createIvSpecByteArray(size: Int): ByteArray {
        return ByteArray(size = size) { 0x00 }
    }
}