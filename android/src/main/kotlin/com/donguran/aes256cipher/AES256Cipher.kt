package com.donguran.aes256cipher

import android.annotation.SuppressLint
import android.util.Base64
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
        val ivSpecSize: Int = params[Constant.paramIvSpec]!! as Int
        val transformation: String = params[Constant.paramTransformation]!! as String

        return try {
            val textBytes:ByteArray = data.toByteArray(Charsets.UTF_8)
            val ivSpec: AlgorithmParameterSpec = IvParameterSpec(createIvSpecByteArray(size = ivSpecSize))
            val newKey: SecretKeySpec = SecretKeySpec(aesKey.toByteArray(Charsets.UTF_8), "AES")
            val cipher: Cipher = Cipher.getInstance(transformation)
            cipher.init(Cipher.ENCRYPT_MODE, newKey, ivSpec)

            Base64.encodeToString(cipher.doFinal(textBytes), Base64.DEFAULT)
        } catch (e: Exception) {
            e.printStackTrace()
            e.message!!
        }
    }

    fun decrypt(params: Map<String, Any?>): String {
        val aesKey: String = params[Constant.paramKey]!! as String
        val data: String = params[Constant.paramData]!! as String
        val ivSpecSize: Int = params[Constant.paramIvSpec]!! as Int
        val transformation: String = params[Constant.paramTransformation]!! as String

        return try {
            val textBytes:ByteArray = Base64.decode(data, 0)
            val ivSpec: AlgorithmParameterSpec = IvParameterSpec(createIvSpecByteArray(size = ivSpecSize))
            val newKey: SecretKeySpec = SecretKeySpec(aesKey.toByteArray(Charsets.UTF_8), "AES")
            val cipher: Cipher = Cipher.getInstance(transformation)
            cipher.init(Cipher.DECRYPT_MODE, newKey, ivSpec)

            cipher.doFinal(textBytes).toString()
        } catch (e: Exception) {
            e.printStackTrace()
            e.message!!
        }
    }

    private fun createIvSpecByteArray(size: Int): ByteArray {
        return ByteArray(size = size) { 0x00 }
    }
}