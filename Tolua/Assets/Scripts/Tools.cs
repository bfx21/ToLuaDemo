using System.Collections.Generic;
using System.IO;
using System.Linq;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;


namespace BaseFramework
{
    public  static class Tools
    {
        public static Transform FindChildObject(this Transform parent,string name)
        {
            Transform target = parent.Find(name);

            if (target != null)
                return target;

            for (int i = 0; i < parent.childCount; i++)
            {
                target = FindChildObject(parent.GetChild(i), name);

                if (target != null)
                    return target;
            }

            return null;
        }

        public static T FindChildObject<T>(this Transform parent, string name) where T :Component
        {
            Transform target = FindChildObject(parent, name);
            if (target != null)
                return target.GetComponent<T>();
            else
            {
                Debug.Log("错误: 找不到" +name + "组件" );
                return null;
            }
        }

        /// <summary>
        /// 将num数随机拆分成n个数
        /// </summary>
        /// <param name="num"></param>
        /// <param name="n"></param>
        /// <param name="flag">集合中是否可以为0</param>
        /// <returns></returns>
        public static List<int> RandomSplit(int num, int n, bool flag = false)
        {
            //随机抽取n-1个小于sum的数
            List<int> list = new List<int>();
            //将0和sum加入到里list中
            list.Add(0);
            //判断生成的正整数集合中是否允许为0，true元素可以为0  false元素不可以为0
            if (!flag)
            {
                num = num - n;
            }
            list.Add(num);

            int temp = 0;

            for (int i = 0; i < n - 1; i++)
            {
                temp = UnityEngine.Random.Range(0, num);
                list.Add(temp);
            }

            list.Sort();

            int[] nums = new int[n];
            for (int i = 0; i < n; i++)
            {
                nums[i] = list[i + 1] - list[i];
                if (!flag)
                {
                    nums[i] += 1;
                }
            }
            return nums.ToList<int>();
        }

        /// <summary>
        ///查找文件路劲
        /// </summary>
        /// <param name="path"></param>
        /// <param name="fileName"></param>
        /// <param name="isFindSuffix">查找的文件路径是否需要加后缀</param>
        /// <returns></returns>
        private static string FindFilePath(string path, string fileName,bool isFindSuffix = true)
        {
            if (!Directory.Exists(path))
                return null;

            string targetPath = "";
            string filePath = "";
            targetPath = path + "/" + fileName;

            filePath = FileExists(path, fileName, isFindSuffix);

            if(filePath != null)
                return filePath;

            string[] childPath = Directory.GetDirectories(path);

            for (int i = 0; i < childPath.Length; i++)
            {
                targetPath = childPath[i] + "/" + fileName;
                filePath = FileExists(path, fileName, isFindSuffix);

                if (filePath != null)
                    return filePath;
                else
                {
                    targetPath = FindFilePath(childPath[i], fileName, isFindSuffix);
                    if (targetPath != null)
                        return targetPath;
                }
            }
            return null;
        }


        /// <summary>
        ///查找文件路径并返回文件路径带后缀
        /// </summary>
        /// <param name="path"></param>
        /// <param name="fileName"></param>
        /// <param name="isFindSuffix">查找的文件路径是否需要加后缀</param>
        /// <returns></returns>
        public static string FindFilePathIsSuffix(string path, string fileName,bool isFindSuffix = false)
        {
            return FindFilePath(path, fileName, isFindSuffix);
        }

        //查找文件路径并返回文件路径不带后缀
        public static string FindFilePathNoSuffix(string path, string fileName, bool isFindSuffix = false)
        {
            string filePath = FindFilePath(path, fileName, isFindSuffix);

            string[] array = filePath.Split('.');

            return array[0];
        }

        private static string FileExists(string path, string fileName, bool isFindSuffix)
        {
            if(isFindSuffix)
            {
                path = path + "/" + fileName;
                if (File.Exists(path))
                    return path;
                else
                    return null;
            }
            else
            {
                return FileExistsNoSuffix(path, fileName);
            }
        }


        private static string FileExistsNoSuffix(string path,string fileName)
        {
            if (!Directory.Exists(path))
                return null;

            string[] filePath = Directory.GetFiles(path);
            string file = "";

            for (int i = 0;i< filePath.Length;i++)
            {
                file = filePath[i].Remove(0, path.Length + 1);
                file = file.Split('.')[0];

                if (file == fileName)
                    return filePath[i];
            }

            return null;
        }

        /// <summary>
        /// 在指定路径下搜索文件并将它以字符串返回
        /// </summary>
        /// <param name="path">搜索路径</param>
        /// <param name="fileName">文件名</param>
        /// <returns></returns>
        public static string GetFileText(string path, string fileName)
        {
            string filePath = FindFilePath(path, fileName);
            if (filePath != null)
                return File.ReadAllText(filePath);
            return null;
        }

        /// <summary>
        /// 在指定路径下搜索文件并将它以字节数组返回
        /// </summary>
        /// <param name="path">搜索路径</param>
        /// <param name="fileName">文件名</param>
        /// <returns></returns>
        public static byte[] GetFileByte(string path, string fileName)
        {
            string filePath = FindFilePath(path, fileName);
            if (filePath != null)
                return File.ReadAllBytes(filePath);

            Debug.Log("找不到该文件："+ fileName);    
            return null;
        }

        /// <summary>
        /// 获得该文件夹下所有的文件信息包括子文件
        /// </summary>
        /// <returns></returns>
        public static FileInfo[] GetDirectorAllFile(DirectoryInfo directory)
        {
            List<FileInfo> list = new List<FileInfo>();
            GetDirectorAllFile(directory,ref list);

            return list.ToArray();
        }

        public static FileInfo[] GetDirectorAllFile(string path)
        {
            return GetDirectorAllFile(new DirectoryInfo(path));
        }

        private static void GetDirectorAllFile(DirectoryInfo directory,ref List<FileInfo> list)
        {
            FileSystemInfo[] fileSystemInfos = directory.GetFileSystemInfos();


            foreach (FileSystemInfo item in fileSystemInfos)
            {
                FileInfo file = item as FileInfo;

                if (file != null)
                {
                    if (file.Extension != ".meta")
                    {
                        list.Add(file);
                    }
                }
                else
                {
                    DirectoryInfo childDir = new DirectoryInfo(item.FullName);
                    GetDirectorAllFile(childDir, ref list);
                }
            }
        }

        public static bool PhyscisRaycast(Ray ray, out RaycastHit hit, float distance)
        {
            return Physics.Raycast(ray, out hit, distance);
        }

        public static RaycastHit[] PhyscisRaycastAll(Ray ray, float distance)
        {
            return Physics.RaycastAll(ray, distance);
        }

        public static bool IsNull(Object obj)
        {
            return obj == null;
        }

        /// <summary>
        /// 随机打乱数组元素
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="arr"></param>
        public static void RandomArray<T>(T[] arr)
        {
            System.Random r = new System.Random();//创建随机类对象，定义引用变量为r
            for (int i = 0; i < arr.Length; i++)
            {
                int index = r.Next(arr.Length);//随机获得0（包括0）到arr.Length（不包括arr.Length）的索引
                                            //Console.WriteLine("index={0}", index);//查看index的值
                T temp = arr[i];  //当前元素和随机元素交换位置
                arr[i] = arr[index];
                arr[index] = temp;
            }
        }

        public static bool GetRandomOdds(int adds)
        {
            int r = Random.Range(1, 101);

            return adds <= r;
        }

        public static void RandomAction(List<KeyValuePair<int, UnityAction>> pairs)
        {
            pairs.Sort((a, b) => { return a.Key > b.Key ? -1 : 1; });

            int r = Random.Range(1, 101);

            int lastOdds = 0;
            int odds = 0;

            for (int i = 0; i < pairs.Count; i++)
            {
                odds = pairs[i].Key + odds;
                if (r > lastOdds && r <= odds)
                {
                    pairs[i].Value();
                }

                lastOdds = odds;
            }
        }

        public static Vector3 WorldToUI(Camera camera, Vector3 pos)
        {
            CanvasScaler scaler = GameObject.Find("UIRoot").GetComponent<CanvasScaler>();

            float resolutionX = scaler.referenceResolution.x;
            float resolutionY = scaler.referenceResolution.y;

            Vector3 viewportPos = camera.WorldToViewportPoint(pos);

            Vector3 uiPos = new Vector3(viewportPos.x * resolutionX - resolutionX * 0.5f,
                viewportPos.y * resolutionY - resolutionY * 0.5f, 0);

            return uiPos;
        }

    }
}
