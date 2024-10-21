//
//  AES256CipherExtension.swift
//  aes256cipher
//
//  Created by Neander on 10/18/24.
//

import Foundation
import CommonCrypto

extension AES256CipherPlugin {
    func encrypt(args params: [String: Any]) -> String {
        // AES Key
        let aesKey: String = params[AES256CipherConstant.paramKey] as! String
        // Decrypted Data
        let data: String = params[AES256CipherConstant.paramData] as! String
        // ivSpec 0x00, 0x00, 0x00, 0x00 ...
        let ivSpecSize: Int8 = params[AES256CipherConstant.paramIvSpec] as! Int8
        // let transformation: String = params[AES256CipherConstant.paramTransformation] as! String
        
        // UTF-8 Encoding and AES256 Encrypted
        let utf8Data: Data = data.data(using: .utf8)!
        
        // AES256Cipher Encrypt
        let encryptedData = utf8Data.aes256Encrypt(key: aesKey, data:utf8Data, ivSpec: ivSpecSize)
        
        // return to Flutter
        if (encryptedData != nil) {
            return encryptedData!.base64EncodedString()
        } else {
            return "BAD_ENCRYPT"
        }
    }
    
    func decrypt(args params: [String: Any]) -> String {
        // AES Key
        let aesKey: String = params[AES256CipherConstant.paramKey] as! String
        // Encrypted Data
        let data: String = params[AES256CipherConstant.paramData] as! String
        // ivSpec 0x00, 0x00, ... x 16
        let ivSpecSize: Int8 = params[AES256CipherConstant.paramIvSpec] as! Int8
        
        // Decode Base64 to Data
        guard let encryptedData = Data(base64Encoded: data) else {
            return "BAD_DECRYPT"
        }
        
        // Extract IV and CipherText
        let ivSize = kCCBlockSizeAES128
        let ivData = encryptedData.prefix(ivSize)
        
        let cipherTextData = encryptedData.suffix(encryptedData.count - ivSize)
        
        // AES256Cipher Decrypt
        do {
            guard let decryptedData = try ivData.aes256Decrypt(key: aesKey, data: cipherTextData, iv: ivData) else {
                return self.errorMessage
            }
            
            return String(data: decryptedData, encoding: .utf8) ?? self.errorMessage
        } catch {
            return "DECRYPTION_FAILED: \(error.localizedDescription)"
        }
        
    }
}


extension Data {
    // Encrypt
    func aes256Encrypt(key: String, data: Data, ivSpec iv: Int8) -> Data? {
        // 32bytes key
        var keyData = Data(key.utf8)
        keyData.count = kCCKeySizeAES256
        
        // ivSpec length is 16
        let ivSize = kCCBlockSizeAES128
        var iv = Data(count: ivSize)
        // RandomSecure
        _ = iv.withUnsafeMutableBytes { ivBytes in
            SecRandomCopyBytes(kSecRandomDefault, ivSize, ivBytes.baseAddress!)
        }
        
        
        let dataLength: Int = data.count
        
        // Setting buffer with data block
        let bufferSize = dataLength + kCCBlockSizeAES128
        var buffer = Data(count: bufferSize)
        
        // Encode bytes
        var encryptedByte: size_t = 0
        
        
        // Execute Encrypt
        let encryptResult = buffer.withUnsafeMutableBytes { bufferBytes in
            data.withUnsafeBytes { dataBytes in
                keyData.withUnsafeBytes { keyBytes in
                    iv.withUnsafeBytes { ivBytes in
                         CCCrypt(
                            CCOperation(kCCEncrypt),
                            CCAlgorithm(kCCAlgorithmAES128),
                            CCOptions(kCCOptionPKCS7Padding),
                            keyBytes.baseAddress,
                            kCCKeySizeAES256,
                            ivBytes.baseAddress,
                            dataBytes.baseAddress,
                            data.count,
                            bufferBytes.baseAddress,
                            bufferSize,
                            &encryptedByte
                         )
                    }
                }
            }
        }
        
        if encryptResult == kCCSuccess {
            return iv + buffer.prefix(encryptedByte)
        } else {
            return nil
        }
    }
    
    // Decrypt
    // Change ivSpecSize -> iv
    func aes256Decrypt(key: String, data: Data, iv: Data) throws -> Data? {
        // 32bytes key
        var keyData = Data(key.utf8)
        keyData.count = kCCKeySizeAES256
        
        let dataLength: Int = data.count
        
        // Decrypted Buffer
        let bufferSize = dataLength + kCCBlockSizeAES128
        var buffer = Data(count: bufferSize)
        
        var decryptBytes: size_t = 0
        
        let decryptResult = buffer.withUnsafeMutableBytes { bufferBytes in
            data.withUnsafeBytes { dataBytes in
                keyData.withUnsafeBytes { keyBytes in
                    iv.withUnsafeBytes { ivBytes in
                        CCCrypt(
                            CCOperation(kCCDecrypt),
                            CCAlgorithm(kCCAlgorithmAES128),
                            CCOptions(kCCOptionPKCS7Padding),
                            keyBytes.baseAddress,
                            kCCKeySizeAES256,
                            ivBytes.baseAddress,
                            dataBytes.baseAddress,
                            data.count,
                            bufferBytes.baseAddress,
                            bufferSize,
                            &decryptBytes
                        )
                    }
                }
            }
        }
        
        if decryptResult == kCCSuccess {
            return buffer.prefix(decryptBytes)
        } else {
            throw NSError(
                domain: "com.donguran.aes256cipher",
                code: Int(decryptResult),
                userInfo: [NSLocalizedDescriptionKey: "Decryption failed with result code:\(decryptResult)"]
            )
        }
    }
}
