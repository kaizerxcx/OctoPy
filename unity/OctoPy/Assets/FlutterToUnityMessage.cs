using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class FlutterToUnityMessage : MonoBehaviour
{
    private UnityMessageManager unitymanager;
    // Start is called before the first frame update
    void Start()
    {
        DontDestroyOnLoad(this.gameObject);
        /*gameObject.AddComponent<UnityMessageManager>();*/
        unitymanager = GetComponent<UnityMessageManager>();
    }

    // Update is called once per frame
    void Update()
    {
        MessengerFlutter();
    }
    public void MessengerFlutter()
    {

       unitymanager.SendMessageToFlutter(" " + SceneManager.GetActiveScene().name);
    }

    public void SwitchNative()
    {
        UnityMessageManager.Instance.ShowHostMainWindow();
    }

    public void UnloadNative()
    {
        UnityMessageManager.Instance.UnloadMainWindow();
    }

    public void QuitNative()
    {
        UnityMessageManager.Instance.QuitUnityWindow();
    }
}
